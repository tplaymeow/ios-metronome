import ComposableArchitecture
import SnapshotTesting
import SwiftUI
import XCTest

open class BaseSnapshotTestCase: XCTestCase {
  open override class func setUp() {
    //    fatalError()
    //    if ProcessInfo.processInfo.environment["GENERATE_SNAPSHOTS"] == "TRUE" {
    //      fatalError()
    //    }
    isRecording = ProcessInfo.processInfo.environment["GENERATE_SNAPSHOTS"] == "TRUE"
  }

  public func makeEmptyStore<State, Action>(
    with state: State
  ) -> Store<State, Action> {
    Store(initialState: state) {
      EmptyReducer()
    }
  }

  public func assertScreenSnapshots(
    of view: some View,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
  ) {
    assertSnapshots(
      of: view,
      as: [
        .image(
          layout: .device(config: .iPhoneSe),
          traits: .init(userInterfaceStyle: .light)),
        .image(
          layout: .device(config: .iPhone13),
          traits: .init(userInterfaceStyle: .light)),
        .image(
          layout: .device(config: .iPhone13ProMax),
          traits: .init(userInterfaceStyle: .light)),
        .image(
          layout: .device(config: .iPhoneSe),
          traits: .init(userInterfaceStyle: .dark)),
        .image(
          layout: .device(config: .iPhone13),
          traits: .init(userInterfaceStyle: .dark)),
        .image(
          layout: .device(config: .iPhone13ProMax),
          traits: .init(userInterfaceStyle: .dark)),
      ],
      file: file,
      testName: testName,
      line: line)
  }
}
