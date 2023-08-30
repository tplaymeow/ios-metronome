import UIKit
import SwiftUI

private let white: UIColor = .init(hex: 0xFFFFFF)
private let black: UIColor = .init(hex: 0x000000)
private let porcelain: UIColor = .init(hex: 0xF2F2F7)
private let darkJungleGreen: UIColor = .init(hex: 0x1C1C1E)

extension Theme {
  public enum Colors {}
}

extension Theme.Colors {
  public enum Surface {
    public static let primary: Color = .dynamic(light: white, dark: black)
    public static let secondary: Color = .dynamic(light: porcelain, dark: darkJungleGreen)
  }
}
