import WidgetKit
import ActivityKit
import MetronomeModels

public struct WidgetActivityAttributes: ActivityAttributes, Sendable {
  public struct ContentState: Codable, Hashable, Sendable {
    public let active: Bool
    public let tempo: Tempo

    public init(active: Bool, tempo: Tempo) {
      self.active = active
      self.tempo = tempo
    }
  }

  public init() {}
}
