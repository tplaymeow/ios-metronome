import Dependencies
import Foundation
import XCTestDynamicOverlay

extension DependencyValues {
  public var appRouterEncoder: AppRouterEncoder {
    get { self[AppRouterEncoder.self] }
    set { self[AppRouterEncoder.self] = newValue }
  }
}

extension AppRouterEncoder: DependencyKey {
  public static var liveValue: Self {
    .init { appRouter.url(for: $0) }
  }

  public static var previewValue: Self {
    .init { appRouter.url(for: $0) }
  }

  public static var testValue: Self {
    .init(unimplemented(#"@Dependency(\.appRouterEncoder)"#))
  }
}

public struct AppRouterEncoder: Sendable {
  @usableFromInline
  internal let url: @Sendable (AppRoute) -> URL

  public init(
    _ url: @escaping @Sendable (AppRoute) -> URL
  ) {
    self.url = url
  }

  @inlinable
  public func callAsFunction(for route: AppRoute) -> URL {
    self.url(route)
  }
}
