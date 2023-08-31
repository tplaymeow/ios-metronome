import Dependencies
import Foundation
import XCTestDynamicOverlay

extension DependencyValues {
  public var appRouterMatcher: AppRouterMatcher {
    get { self[AppRouterMatcher.self] }
    set { self[AppRouterMatcher.self] = newValue }
  }
}

extension AppRouterMatcher: DependencyKey {
  public static var liveValue: Self {
    .init { try appRouter.match(url: $0) }
  }

  public static var previewValue: Self {
    .init { try appRouter.match(url: $0) }
  }

  public static var testValue: Self {
    .init(unimplemented(#"@Dependency(\.appRouterMatcher)"#))
  }
}

public struct AppRouterMatcher: Sendable {
  @usableFromInline
  internal let match: @Sendable (URL) throws -> AppRoute

  public init(
    _ match: @escaping @Sendable (URL) throws -> AppRoute
  ) {
    self.match = match
  }

  @inlinable
  public func callAsFunction(url: URL) throws -> AppRoute {
    try self.match(url)
  }
}
