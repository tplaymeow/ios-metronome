import ActivityKit
import Dependencies
import DependenciesAdditionsBasics

extension ActivityClient: DependencyKey {
  public static var testValue: Self {
    .unimplemented
  }

  public static var previewValue: Self {
    .dummy
  }
}

public struct ActivityClient<Attributes: ActivityAttributes>: ConfigurableProxy, Sendable
where
  Attributes: Sendable,
  Attributes.ContentState: Sendable
{
  public struct Implementation: Sendable {
    @FunctionProxy
    public var request:
      @Sendable (Attributes, Attributes.ContentState, PushType?) async throws -> Void

    @FunctionProxy
    public var update: @Sendable (Attributes.ContentState) async throws -> Void

    @FunctionProxy
    public var end:
      @Sendable (Attributes.ContentState?, ActivityUIDismissalPolicy) async throws -> Void
  }

  @_spi(Internals)
  public var _implementation: Implementation

  public func request(
    attributes: Attributes,
    contentState: Attributes.ContentState,
    pushType: PushType? = nil
  ) async throws {
    try await self._implementation.request(attributes, contentState, pushType)
  }

  public func update(using contentState: Attributes.ContentState) async throws {
    try await self._implementation.update(contentState)
  }

  public func end(
    using contentState: Activity<Attributes>.ContentState? = nil,
    dismissalPolicy: ActivityUIDismissalPolicy = .default
  ) async throws {
    try await self._implementation.end(contentState, dismissalPolicy)
  }
}

extension ActivityClient {
  enum Error: Swift.Error {
    case notSetup
  }
}
