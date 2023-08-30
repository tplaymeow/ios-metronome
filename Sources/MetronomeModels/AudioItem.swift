import Foundation

public struct AudioItem: Equatable, Sendable {
  public let url: URL

  @inlinable
  public init(url: URL) {
    self.url = url
  }
}
