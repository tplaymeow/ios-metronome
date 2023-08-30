import Foundation
import DependenciesAdditions

private let metronomeActiveKey = "METRONOME_ACTIVE_KEY"

extension UserDefaults.Dependency {
  public var metronomeActive: Bool? {
    get {
      self.bool(forKey: metronomeActiveKey)
    }
    nonmutating set {
      self.set(newValue, forKey: metronomeActiveKey)
    }
  }
}
