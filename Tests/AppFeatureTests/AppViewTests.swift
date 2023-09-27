import AppFeature
import ComposableArchitecture
import SnapshotTesting
import TestHelpers
import XCTest

@MainActor
final class AppViewTests: BaseSnapshotTestCase {
  func testNotActive() {
    let state: AppFeature.State = .init()
    self.assertScreenSnapshots(
      of: AppView(
        store: self.makeEmptyStore(with: state)
      )
    )
  }

  func testActiveLowVolume() {
    var state: AppFeature.State = .init()
    state.active = true
    state.outputVolume = 0.1
    self.assertScreenSnapshots(
      of: AppView(
        store: self.makeEmptyStore(with: state)
      )
    )
  }

  func testActiveMiddleVolume() {
    var state: AppFeature.State = .init()
    state.active = true
    state.outputVolume = 0.5
    self.assertScreenSnapshots(
      of: AppView(
        store: self.makeEmptyStore(with: state)
      )
    )
  }

  func testActiveHighVolume() {
    var state: AppFeature.State = .init()
    state.active = true
    state.outputVolume = 0.9
    self.assertScreenSnapshots(
      of: AppView(
        store: self.makeEmptyStore(with: state)
      )
    )
  }

  func testLongTempo() {
    var state: AppFeature.State = .init()
    state.tempo = .init(bpm: 225)
    self.assertScreenSnapshots(
      of: AppView(
        store: self.makeEmptyStore(with: state)
      )
    )
  }
}
