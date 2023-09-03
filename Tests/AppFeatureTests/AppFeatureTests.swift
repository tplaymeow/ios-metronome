import AppFeature
import ComposableArchitecture
import MetronomeModels
import XCTest

final class AppFeatureTests: XCTestCase {
  @MainActor
  func testAppear() async {
    let audioSessionSetCalled: LockIsolated<Bool> = .init(false)
    let audioSessionActivateCalled: LockIsolated<Bool> = .init(false)
    let metronomeSetupCalled: LockIsolated<Bool> = .init(false)

    let store: TestStoreOf<AppFeature> = TestStoreOf<AppFeature>(
      initialState: AppFeature.State()
    ) {
      AppFeature()
    } withDependencies: {
      $0.userDefaults = .ephemeral()
      $0.userDefaults.metronomeTempo = Tempo(bpm: 60)

      $0.audioSession.$set = { @Sendable _, _, _ in
        audioSessionSetCalled.setValue(true)
      }
      $0.audioSession.$activate = { @Sendable in
        audioSessionActivateCalled.setValue(true)
      }
      $0.audioSession.$observeOutputVolume = { @Sendable in
        .finished
      }

      $0.metronome.$setup = { @Sendable _ async throws -> Void in
        metronomeSetupCalled.setValue(true)
      }
    }

    await store.send(AppFeature.Action.onAppear) {
      $0.appearedOnce = true
      $0.tempo = Tempo(bpm: 60)
    }

    audioSessionSetCalled.withValue {
      XCTAssertTrue($0)
    }

    audioSessionActivateCalled.withValue {
      XCTAssertTrue($0)
    }

    metronomeSetupCalled.withValue {
      XCTAssertTrue($0)
    }
  }
}
