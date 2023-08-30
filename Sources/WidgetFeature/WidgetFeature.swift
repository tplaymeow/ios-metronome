@preconcurrency import WidgetKit
import ComposableArchitecture
import UserDefaultsDependency
import UserDefaultsExtensions
import MetronomeModels

public struct WidgetFeature: Reducer {
  public struct State: Sendable {
    public var timelinePlaceholder: Entry = .default
    public var timelineSnapshot: Entry = .default
    public var timeline: Timeline<Entry> = .init(entries: [.default], policy: .never)

    public init() {}
  }

  public struct Entry: TimelineEntry, Sendable {
    public let date: Date
    public let tempo: Tempo

    static var `default`: Self {
      .init(date: Date(), tempo: .init(bpm: 60))
    }
  }

  public enum Action {
    case timelineProviderRequestsPlaceholder(TimelineProviderContext)
    case timelineProviderRequestsSnapshot(TimelineProviderContext)
    case timelineProviderRequestsTimeline(TimelineProviderContext)
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .timelineProviderRequestsPlaceholder(context):
        if context.isPreview {
          state.timelinePlaceholder = .default
        } else {
          state.timelinePlaceholder = self.fetchEntry() ?? .default
        }
        return .none

      case let .timelineProviderRequestsSnapshot(context):
        if context.isPreview {
          state.timelineSnapshot = .default
        } else {
          state.timelineSnapshot = self.fetchEntry() ?? .default
        }
        return .none

      case let .timelineProviderRequestsTimeline(context):
        let entry: Entry = if context.isPreview {
          .default
        } else {
          self.fetchEntry() ?? .default
        }
        state.timeline = Timeline(entries: [entry], policy: .never)
        return.none
      }
    }
  }

  public init() {}

  @Dependency(\.userDefaults)
  private var userDefaults

  private func fetchEntry() -> Entry? {
    guard 
      let tempo = self.userDefaults.metronomeTempo
    else {
      return nil
    }

    return Entry(date: Date(), tempo: tempo)
  }
}
