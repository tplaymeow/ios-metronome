import DependenciesAdditions
import Foundation

@usableFromInline
internal let metronomeActiveKey = "METRONOME_ACTIVE_KEY"

extension UserDefaults.Dependency {
  @inlinable
  public var metronomeActive: Bool? {
    get {
      self.bool(forKey: metronomeActiveKey)
    }
    nonmutating set {
      self.set(newValue, forKey: metronomeActiveKey)
    }
  }
}
