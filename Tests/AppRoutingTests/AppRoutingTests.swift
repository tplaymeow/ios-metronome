import XCTest
import AppRouting

final class AppRoutingTests: XCTestCase {
  func testMatcher() throws {
    let match = AppRouterMatcher.liveValue

    XCTAssertEqual(
      try match(url: URL(string: "tplaymeow://metronome/")!),
      .default
    )

    XCTAssertEqual(
      try match(url: URL(string: "tplaymeow://metronome/startMetronome")!),
      .startMetronome
    )
  }

  func testEncoder() {
    let encode = AppRouterEncoder.liveValue

    XCTAssertEqual(
      encode(for: .default),
      URL(string: "tplaymeow://metronome/")!
    )

    XCTAssertEqual(
      encode(for: .startMetronome),
      URL(string: "tplaymeow://metronome/startMetronome")!
    )
  }
}
