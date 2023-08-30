import Foundation

extension FormatStyle where Self == EmojiFormatStyle<Int> {
  public static var emoji: Self {
    EmojiFormatStyle()
  }
}

public struct EmojiFormatStyle<Value: BinaryInteger>: FormatStyle {
  public func format(_ value: Value) -> String {
    value
      .formatted()
      .compactMap(\.wholeNumberValue)
      .compactMap(Self.emoji)
      .joined()
  }

  private static func emoji(for digit: Int) -> String? {
    switch digit {
    case 0: "0️⃣"
    case 1: "1️⃣"
    case 2: "2️⃣"
    case 3: "3️⃣"
    case 4: "4️⃣"
    case 5: "5️⃣"
    case 6: "6️⃣"
    case 7: "7️⃣"
    case 8: "8️⃣"
    case 9: "9️⃣"
    default: nil
    }
  }
}
