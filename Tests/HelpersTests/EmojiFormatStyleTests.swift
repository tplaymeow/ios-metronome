import Helpers
import Foundation
import Testing

@Suite
struct EmojiFormatStyleTests {
  @Test
  func formatStyle() {
    #expect(123_456_789.formatted(.emoji) == "1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣")
    #expect(1000.formatted(.emoji) == "1️⃣0️⃣0️⃣0️⃣")
    #expect((-1000).formatted(.emoji) == "1️⃣0️⃣0️⃣0️⃣")
  }
}
