import ConcurrencyExtras
import Helpers
import XCTest

final class AsyncObserveTests: XCTestCase {
  func testAsyncObserve() async {
    class Object: NSObject {
      @objc dynamic var value: Int = 0
    }

    let expectation = XCTestExpectation()
    expectation.expectedFulfillmentCount = 3

    let object = Object()
    let stream = object.asyncObserve(for: \.value)
    let streamValues: ActorIsolated<[Int]> = .init([])

    Task {
      for await value in stream {
        await streamValues.withValue { $0.append(value) }
        expectation.fulfill()
      }
    }

    object.value += 1
    object.value += 2

    await self.fulfillment(of: [expectation])
    await streamValues.withValue {
      XCTAssertEqual($0, [0, 1, 3])
    }
  }
}
