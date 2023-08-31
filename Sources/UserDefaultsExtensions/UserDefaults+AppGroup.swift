import Foundation
import UserDefaultsDependency

extension UserDefaults.Dependency {
  @inlinable
  public static var appGroup: Self {
    .init(suitename: "group.com.tplaymeow.Metronome.AppGroup")!
  }
}
