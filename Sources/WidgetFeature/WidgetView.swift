import SwiftUI
import Design
import Helpers
import AppRouting
import Dependencies

public struct WidgetView: View {
  public var body: some View {
    switch self.widgetFamily {
    case .systemSmall:
      SmallWidgetView(entry: self.entry)

    case .systemMedium:
      MediumWidgetView(entry: self.entry)

    default:
      EmptyView()
    }
  }

  public init(entry: WidgetFeature.Entry) {
    self.entry = entry
  }

  private let entry: WidgetFeature.Entry

  @Environment(\.widgetFamily)
  private var widgetFamily
}

private struct SmallWidgetView: View {
  var body: some View {
    VStack(spacing: -containerInset) {
      Container {
        Text("🔉")
          .font(.largeTitle)
      }

      Container {
        Text(self.entry.tempo.bpm.formatted(.emoji))
          .font(.largeTitle)
      }
    }
    .background(Theme.Colors.Surface.primary)
    .widgetURL(self.url(for: .default))
  }

  public init(entry: WidgetFeature.Entry) {
    self.entry = entry
  }

  private let entry: WidgetFeature.Entry

  @Dependency(\.appRouterEncoder)
  private var url
}

private struct MediumWidgetView: View {
  var body: some View {
    HStack(spacing: -containerInset) {
      Container {
        Text("🔉")
          .font(.system(size: 80.0))
      }

      VStack(spacing: -containerInset) {
        Container {
          Text(self.entry.tempo.bpm.formatted(.emoji))
            .font(.largeTitle)
        }

        Link(destination: self.url(for: .startMetronome)) {
          Container {
            Text("▶️")
              .font(.largeTitle)
          }
        }
      }
    }
    .background(Theme.Colors.Surface.primary)
    .widgetURL(self.url(for: .default))
  }

  public init(entry: WidgetFeature.Entry) {
    self.entry = entry
  }

  private let entry: WidgetFeature.Entry

  @Dependency(\.appRouterEncoder)
  private var url
}

private struct Container<Label: View>: View {
  var body: some View {
    ZStack {
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
