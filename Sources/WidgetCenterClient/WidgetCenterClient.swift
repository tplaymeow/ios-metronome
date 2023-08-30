import Dependencies
import DependenciesAdditionsBasics

extension DependencyValues {
  public var widgetCenter: WidgetCenterClient {
    get { self[WidgetCenterClient.self] }
    set { self[WidgetCenterClient.self] = newValue }
  }
}

extension WidgetCenterClient: DependencyKey {
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

public struct WidgetCenterClient: ConfigurableProxy, Sendable {
  public struct Implementation: Sendable {
    @FunctionProxy
    public var reloadAllTimelines: @Sendable () -> Void
  }

  @_spi(Internals)
  public var _implementation: Implementation

  public func reloadAllTimelines() {
    self._implementation.reloadAllTimelines()
  }
}
