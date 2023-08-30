import Foundation
import ComposableArchitecture
import AssertionDependency
import UserDefaultsDependency
import MetronomeClient
import AudioSessionClient
import UserDefaultsExtensions
import MetronomeModels
import WidgetCenterClient
import AppRouting
import ActivityClient
import WidgetLiveActivityClient
import WidgetActivityAttributes

// TODO: Remove this import
// I have to explicitly import SwiftUINavigationCore with @preconcurrency
// because AlertState not Sendable now
// https://github.com/pointfreeco/swiftui-navigation/pull/116
@preconcurrency import SwiftUINavigationCore

public struct AppFeature: Reducer, Sendable {
  public struct State: Sendable {
    public var appearedOnce: Bool = false
    public var active: Bool = false
    public var outputVolume: Float = 0.0
    public var tempo: Tempo = .init(bpm: 60)

    @PresentationState
    public var alert: AlertState<AlertAction>?

    public var liveActivityState: WidgetActivityAttributes.ContentState {
      .init(active: self.active, tempo: self.tempo)
    }

    public init() {}
  }

  public enum Action: Sendable {
    case onAppear
    case openURL(URL)
    case setupMetronomeError
    case setupAudioSessionError
    case startMetronomeError
    case startMetronome
    case updateTempo(offset: Int)
    case updateOutputVolume(volume: Float)
    case alert(PresentationAction<AlertAction>)
  }

  public enum AlertAction: Sendable {
    case setupMetronome
    case setupAudioSession
    case startMetronome
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear where state.appearedOnce:
        return .none

      case .onAppear:
        state.appearedOnce = true
        state.tempo = self.userDefaults.metronomeTempo ?? state.tempo
        return .merge(
          self.setupAudioSession(),
          self.setupMetronome(),
          .run { send in
            for await outputVolume in self.audioSession.observeOutputVolume() {
              await send(.updateOutputVolume(volume: outputVolume))
            }
          },
          .run { [liveActivityState = state.liveActivityState] _ in
            try await self.widgetLiveActivity.request(
              attributes: .init(),
              contentState: liveActivityState)
          } catch: { error, _ in
            self.assertionFailure(error.localizedDescription)
          }
        )

      case let .openURL(url):
        let route = (try? self.match(url: url)) ?? .default
        switch route {
        case .default:
          return .none

        case .startMetronome:
          return .merge(
            self.startMetronome(state: &state),
            self.syncLiveActivity(state: &state)
          )

        case .stopMetronome:
          return .merge(
            self.stopMetronome(state: &state),
            self.syncLiveActivity(state: &state)
          )
        }

      case .startMetronome where state.active:
        return .merge(
          self.stopMetronome(state: &state),
          self.syncLiveActivity(state: &state)
        )

      case .startMetronome:
        return .merge(
          self.startMetronome(state: &state),
          self.syncLiveActivity(state: &state)
        )

      case let .updateTempo(offset):
        state.tempo.increase(on: offset)
        self.userDefaults.metronomeTempo = state.tempo
        self.widgetCenter.reloadAllTimelines()
        if state.active {
          return .merge(
            self.startMetronome(state: &state),
            self.syncLiveActivity(state: &state)
          )
        } else {
          return self.syncLiveActivity(state: &state)
        }

      case let .updateOutputVolume(volume):
        state.outputVolume = volume
        return .none

      case .setupAudioSessionError:
        state.alert = AlertState {
          TextState("Audio system error")
        } actions: {
          ButtonState(action: .setupAudioSession) {
            TextState("Try again")
          }
        }
        return .none

      case .setupMetronomeError:
        state.alert = AlertState {
          TextState("Audio system error")
        } actions: {
          ButtonState(action: .setupMetronome) {
            TextState("Try again")
          }
        }
        return .none

      case .startMetronomeError:
        state.alert = AlertState {
          TextState("Audio system error")
        } actions: {
          ButtonState(action: .startMetronome) {
            TextState("Try again")
          }
        }
        return self.stopMetronome(state: &state)

      case .alert(.presented(.setupMetronome)):
        return self.setupMetronome()

      case .alert(.presented(.setupAudioSession)):
        return self.setupAudioSession()

      case .alert(.presented(.startMetronome)):
        return self.startMetronome(state: &state)

      case .alert(.dismiss):
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
  }

  public init() {}

  @Dependency(\.userDefaults)
  private var userDefaults

  @Dependency(\.audioSession)
  private var audioSession

  @Dependency(\.metronome)
  private var metronome

  @Dependency(\.widgetCenter)
  private var widgetCenter

  @Dependency(\.appRouterMatcher)
  private var match

  @Dependency(\.widgetLiveActivity)
  private var widgetLiveActivity

  @Dependency(\.assertionFailure)
  private var assertionFailure

  private var metronomeTickURL: URL {
    Bundle.module.url(forResource: "metronome-tick", withExtension: "wav")!
  }

  private func setupAudioSession() -> Effect<Action> {
    .run { _ in
      try self.audioSession.set(category: .playback, mode: .default, policy: .longFormAudio)
      try self.audioSession.activate()
    } catch: { _, send in
      await send(.setupAudioSessionError)
    }
  }

  private func setupMetronome() -> Effect<Action> {
    .run { _ in
      let url = self.metronomeTickURL
      let item = AudioItem(url: url)
      try await self.metronome.setup(with: item)
    } catch: { _, send in
      await send(.setupMetronomeError)
    }
  }

  private func startMetronome(state: inout State) -> Effect<Action> {
    state.active = true
    return .run { [tempo = state.tempo] _ in
      try await self.metronome.play(with: tempo)
    } catch: { _, send in
      await send(.startMetronomeError)
    }
  }

  private func stopMetronome(state: inout State) -> Effect<Action> {
    state.active = false
    return .run { _ in
      await self.metronome.stop()
    }
  }

  private func syncLiveActivity(state: inout State) -> Effect<Action> {
    .run { [liveActivityState = state.liveActivityState] _ in
      try await self.widgetLiveActivity.update(using: liveActivityState)
    } catch: { error, _ in
      self.assertionFailure(error.localizedDescription)
    }
  }
}
