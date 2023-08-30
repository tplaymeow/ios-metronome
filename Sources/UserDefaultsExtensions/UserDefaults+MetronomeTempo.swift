import Foundation
import DependenciesAdditions
import MetronomeModels

private let metronomeBPMKey = "METRONOME_BPM_KEY"

extension UserDefaults.Dependency {
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
