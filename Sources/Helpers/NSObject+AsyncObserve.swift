import Foundation

@_marker
public protocol _AsyncKeyValueObserving {}

extension NSObject: _AsyncKeyValueObserving {}

extension _AsyncKeyValueObserving where Self: NSObject {
  public func asyncObserve<Value>(
    for keyPath: KeyPath<Self, Value>,
    options: NSKeyValueObservingOptions = [.initial, .new]
  ) -> AsyncStream<Value> {
    AsyncStream { continuation in
      let observation = self.observe(keyPath, options: options) { object, _ in
        continuation.yield(object[keyPath: keyPath])
      }
      continuation.onTermination = { _ in
        observation.invalidate()
      }
    }
  }
}
