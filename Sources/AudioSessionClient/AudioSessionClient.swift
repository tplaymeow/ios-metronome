import Dependencies
import DependenciesAdditionsBasics

extension DependencyValues {
  public var audioSession: AudioSessionClient {
    get { self[AudioSessionClient.self] }
    set { self[AudioSessionClient.self] = newValue }
  }
}

extension AudioSessionClient: DependencyKey {
  public static var liveValue: Self {
    .shared
  }

  public static var previewValue: Self {
    .shared
  }

  public static var testValue: Self {
    .unimplemented
  }
}

public struct AudioSessionClient: ConfigurableProxy, Sendable {
  public struct Implementation: Sendable {
    @ReadOnlyProxy
    public var category: @Sendable () -> Category

    @ReadOnlyProxy
    public var mode: @Sendable () -> Mode

    @ReadOnlyProxy
    public var routeSharingPolicy: @Sendable () -> RouteSharingPolicy

    @FunctionProxy
    public var set: @Sendable (Category, Mode, RouteSharingPolicy) throws -> Void

    @FunctionProxy
    public var activate: @Sendable () throws -> Void

    @FunctionProxy
    public var deactivate: @Sendable () throws -> Void

    @FunctionProxy
    public var observeOutputVolume: @Sendable () -> AsyncStream<Float>
  }

  @_spi(Internals)
  public var _implementation: Implementation

  public var category: Category {
    self._implementation.category()
  }

  public var mode: Mode {
    self._implementation.mode()
  }

  public var routeSharingPolicy: RouteSharingPolicy {
    self._implementation.routeSharingPolicy()
  }

  public func set(
    category: Category,
    mode: Mode,
    policy: RouteSharingPolicy
  ) throws {
    try self._implementation.set(category, mode, policy)
  }

  public func activate() throws {
    try self._implementation.activate()
  }

  public func deactivate() throws {
    try self._implementation.deactivate()
  }

  public func observeOutputVolume() -> AsyncStream<Float> {
    self._implementation.observeOutputVolume()
  }
}

extension AudioSessionClient {
  // TODO: Add other categories
  public enum Category {
    case unknown
    case playback
  }

  // TODO: Add other modes
  public enum Mode {
    case unknown
    case `default`
  }

  // TODO: Add other policies
  public enum RouteSharingPolicy {
    case unknown
    case longFormAudio
  }
}
