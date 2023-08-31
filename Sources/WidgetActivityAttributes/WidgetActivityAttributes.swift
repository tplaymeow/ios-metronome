import ActivityKit
import MetronomeModels
import WidgetKit

public struct WidgetActivityAttributes: ActivityAttributes, Sendable {
  public struct ContentState: Codable, Hashable, Sendable {
    public let active: Bool
    public let tempo: Tempo

    @inlinable
    public init(active: Bool, tempo: Tempo) {
      self.active = active
      self.tempo = tempo
    }
  }

  @inlinable
  public init() {}
}
