import Foundation

public struct Tempo: Equatable, Codable, Hashable, Sendable {
  public let bpm: Int

  @inlinable
  public var bps: Double {
    Double(self.bpm) / 60.0
  }

  @inlinable
  public var duration: Duration {
    .nanoseconds(60_000_000_000 / self.bpm)
  }

  @inlinable
  public var timeInterval: TimeInterval {
    60.0 / Double(self.bpm)
  }

  @inlinable
  public init(bpm: Int) {
    self.bpm = bpm
  }

  @inlinable
  public func increased(on offset: Int) -> Self {
    .init(bpm: self.bpm + offset)
  }

  @inlinable
  public mutating func increase(on offset: Int) {
    self = self.increased(on: offset)
  }
}
