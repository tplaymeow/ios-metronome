import SwiftUI
import Helpers

extension AppView {
  struct State: Equatable, Sendable {
    let titleText: String
    let tempoText: String
    let startButtonText: String
  }
}

extension AppFeature.State {
  var view: AppView.State {
    let titleText = if self.active {
      switch self.outputVolume {
      case 0.0...(1.0 / 3.0): "🔈"
      case (1.0 / 3.0)...(2.0 / 3.0): "🔉"
      default: "🔊"
      }
    } else {
      "🔇"
    }

    let tempoText = self.tempo.bpm
      .formatted(.emoji)

    let startButtonText = if self.active {
      "⏸️"
    } else {
      "▶️"
    }

    return .init(
      titleText: titleText,
      tempoText: tempoText,
      startButtonText: startButtonText
    )
  }
}

extension AppView {
  enum Action {
    case onAppear
    case startButtonTapped
    case decreaseTapped
    case increaseTapped
  }
}

extension AppFeature.Action {
  static func view(_ viewAction: AppView.Action) -> Self {
    switch viewAction {
    case .onAppear: .onAppear
    case .startButtonTapped: .startMetronome
    case .decreaseTapped: .updateTempo(offset: -1)
    case .increaseTapped: .updateTempo(offset: 1)
    }
  }
}
