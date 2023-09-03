import Helpers
import XCTest

final class EmojiFormatStyleTests: XCTestCase {
  func testFormatStyle() {
    XCTAssertEqual(123_456_789.formatted(.emoji), "1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣")
    XCTAssertEqual(1000.formatted(.emoji), "1️⃣0️⃣0️⃣0️⃣")
    XCTAssertEqual((-1000).formatted(.emoji), "1️⃣0️⃣0️⃣0️⃣")
  }
}
