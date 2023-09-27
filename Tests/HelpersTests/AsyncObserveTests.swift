import ConcurrencyExtras
import Helpers
import Foundation
import Testing

@Suite
struct AsyncObserveTests {
  @Test(.disabled())
  func asyncObserve() async {
    class Object: NSObject {
      @objc dynamic var value: Int = 0
    }

    let object = Object()
    let stream = object.asyncObserve(for: \.value)
    let streamValues: ActorIsolated<[Int]> = .init([])

    object.value += 1
    object.value += 2

    await confirmation(expectedCount: 3) { confirm in
      for await value in stream {
        await streamValues.withValue { $0.append(value) }
        confirm()
      }
    }

    await streamValues.withValue { values in
      #expect(values == [0, 1, 3])
    }
  }
}
