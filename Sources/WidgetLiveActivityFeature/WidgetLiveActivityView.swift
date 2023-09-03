import ActivityKit
import AppRouting
import Dependencies
import Design
import Helpers
import SwiftUI
import WidgetActivityAttributes
import WidgetKit

public struct WidgetLiveActivityView: View {
  public var body: some View {
    HStack(spacing: -containerInset) {
      Container {
        let title = switch self.state.outputVolume {
        case 0.0...(1.0 / 3.0): "🔈"
        case (1.0 / 3.0)...(2.0 / 3.0): "🔉"
        default: "🔊"
        }
        Text(title)
          .font(.system(size: 80.0))
      }

      VStack(spacing: -containerInset) {
        Container {
          Text(self.state.tempo.bpm.formatted(.emoji))
        }

        Link(destination: self.url(for: .stopMetronome)) {
          Container {
            Text("⏸️")
          }
        }
      }
    }
    .background(Theme.Colors.Surface.primary)
    .widgetURL(self.url(for: .default))
  }

  public init(state: WidgetActivityAttributes.ContentState) {
    self.state = state
  }

  private let state: WidgetActivityAttributes.ContentState

  @Dependency(\.appRouterEncoder)
  private var url
}

private struct Container<Label: View>: View {
  var body: some View {
    ZStack(alignment: .center) {
      ContainerRelativeShape()
        .inset(by: containerInset)
        .fill(Theme.Colors.Surface.secondary)

      self.label
    }
  }

  init(@ViewBuilder label: () -> Label) {
    self.label = label()
  }

  private let label: Label
}

private let containerInset: CGFloat = 8.0
