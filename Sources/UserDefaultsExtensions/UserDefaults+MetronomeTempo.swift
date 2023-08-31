import DependenciesAdditions
import Foundation
import MetronomeModels

@usableFromInline
internal let metronomeBPMKey = "METRONOME_BPM_KEY"

extension UserDefaults.Dependency {
  @inlinable
  public var metronomeTempo: Tempo? {
    get {
      self.integer(forKey: metronomeBPMKey)
        .map(Tempo.init)
    }
    nonmutating set {
      if let newValue {
        self.set(newValue.bpm, forKey: metronomeBPMKey)
      } else {
        self.removeValue(forKey: metronomeBPMKey)
      }
    }
  }
}
