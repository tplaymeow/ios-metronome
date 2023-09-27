import AppRouting
import Foundation
import Testing

@Suite
struct AppRoutingTests {
  @Test
  func matcher() throws {
    let match = AppRouterMatcher.liveValue

    #expect(try match(url: URL(string: "tplaymeow://metronome/")!) == .default)
    #expect(try match(url: URL(string: "tplaymeow://metronome/startMetronome")!) == .startMetronome)
    #expect(try match(url: URL(string: "tplaymeow://metronome/stopMetronome")!) == .stopMetronome)
  }

  @Test
  func encoder() throws {
    let encode = AppRouterEncoder.liveValue

    #expect(encode(for: .default) == URL(string: "tplaymeow://metronome/")!)
    #expect(encode(for: .startMetronome) == URL(string: "tplaymeow://metronome/startMetronome")!)
    #expect(encode(for: .stopMetronome) == URL(string: "tplaymeow://metronome/stopMetronome")!)
  }
}
