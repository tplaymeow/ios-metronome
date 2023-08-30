import AVFoundation
import Helpers

extension AudioSessionClient {
  public static var shared: Self {
    .init(
      _implementation: .init(
        category: .init {
          .init(AVAudioSession.sharedInstance().category)
        },
        mode: .init {
          .init(AVAudioSession.sharedInstance().mode)
        },
        routeSharingPolicy: .init {
          .init(AVAudioSession.sharedInstance().routeSharingPolicy)
        },
        set: .init { category, mode, policy in
          try AVAudioSession.sharedInstance().setCategory(
            category.av,
            mode: mode.av,
            policy: policy.av)
        },
        activate: .init {
          try AVAudioSession.sharedInstance().setActive(true, options: [])
        },
        deactivate: .init {
          try AVAudioSession.sharedInstance().setActive(false, options: [])
        },
        observeOutputVolume: .init {
          AVAudioSession.sharedInstance().asyncObserve(for: \.outputVolume)
        }
      )
    )
  }
}

extension AudioSessionClient.Category {
  fileprivate init(_ category: AVAudioSession.Category) {
    switch category {
    case .playback:
      self = .playback
    default:
      self = .unknown
    }
  }

  fileprivate var av: AVAudioSession.Category {
    switch self {
    case .playback:
      return .playback
    case .unknown:
      return .playback
    }
  }
}

extension AudioSessionClient.Mode {
  fileprivate init(_ mode: AVAudioSession.Mode) {
    switch mode {
    case .default:
      self = .default
    default:
      self = .unknown
    }
  }

  fileprivate var av: AVAudioSession.Mode {
    switch self {
    case .default:
      return .default
    case .unknown:
      return .default
    }
  }
}

extension AudioSessionClient.RouteSharingPolicy {
  fileprivate init(_ policy: AVAudioSession.RouteSharingPolicy) {
    switch policy {
    case .longFormAudio:
      self = .longFormAudio
    default:
      self = .unknown
    }
  }

  fileprivate var av: AVAudioSession.RouteSharingPolicy {
    switch self {
    case .longFormAudio:
      return .longFormAudio
    case .unknown:
      return .default
    }
  }
}
