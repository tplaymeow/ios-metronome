import Foundation
import Dependencies
import DependenciesAdditionsBasics
import MetronomeModels

extension DependencyValues {
  public var metronome: MetronomeClient {
    get { self[MetronomeClient.self] }
    set { self[MetronomeClient.self] = newValue }
  }
}

extension MetronomeClient: DependencyKey {
  public static var previewValue: Self {
    .dummy
  }

  public static var testValue: Self {
    .unimplemented
  }
}

public struct MetronomeClient: ConfigurableProxy, Sendable {
  public struct Implementation: Sendable {
    @FunctionProxy
    public var setup: @Sendable (AudioItem) async throws -> Void

    @FunctionProxy
    public var play: @Sendable (Tempo) async throws -> Void

    @FunctionProxy
    public var stop: @Sendable () async -> Void
  }

  @_spi(Internals)
  public var _implementation: Implementation

  public func setup(with item: AudioItem) async throws {
    try await self._implementation.setup(item)
  }

  public func play(with tempo: Tempo) async throws {
    try await self._implementation.play(tempo)
  }

  public func stop() async {
    await self._implementation.stop()
  }
}

extension MetronomeClient {
  public enum Error: Swift.Error {
    case notSetup
    case setupError(underlying: any Swift.Error)
    case startError(underlying: (any Swift.Error)?)
  }
}
