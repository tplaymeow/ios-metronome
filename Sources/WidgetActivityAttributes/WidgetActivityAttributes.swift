import ActivityKit
import MetronomeModels
import WidgetKit

public struct WidgetActivityAttributes: ActivityAttributes, Sendable {
  public struct ContentState: Codable, Hashable, Sendable {
    public let tempo: Tempo
    public let outputVolume: Float

    @inlinable
    public init(tempo: Tempo, outputVolume: Float) {
      self.tempo = tempo
      self.outputVolume = outputVolume
    }
  }

  @inlinable
  public init() {}
}
