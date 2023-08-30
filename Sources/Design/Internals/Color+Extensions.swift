import SwiftUI
import UIKit

extension Color {
  static func dynamic(
    light lightModeColor: @escaping @autoclosure () -> UIColor,
    dark darkModeColor: @escaping @autoclosure () -> UIColor
  ) -> Self {
    Color(
      UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
          return lightModeColor()
        case .dark:
          return darkModeColor()
        @unknown default:
          return lightModeColor()
        }
      }
    )
  }
}

extension UIColor {
  convenience init(hex: UInt, alpha: Double = 1.0) {
    self.init(
      red: Double((hex >> 16) & 0xff) / 255.0,
      green: Double((hex >> 08) & 0xff) / 255.0,
      blue: Double((hex >> 00) & 0xff) / 255.0,
      alpha: alpha)
  }
}
