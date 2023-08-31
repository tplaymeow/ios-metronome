import ComposableArchitecture
import SwiftUI
import UserDefaultsDependency
import UserDefaultsExtensions
import WidgetFeature
import WidgetKit

struct MetronomeWidgetTimelineProvider: TimelineProvider {
  func placeholder(in context: Context) -> WidgetFeature.Entry {
    self.store.send(.timelineProviderRequestsPlaceholder(context))
    return self.store.withState(\.timelinePlaceholder)
  }

  func getSnapshot(
    in context: Context,
    completion: @escaping (WidgetFeature.Entry) -> Void
  ) {
    Task {
      await self.store.send(.timelineProviderRequestsSnapshot(context)).finish()
      completion(self.store.withState(\.timelineSnapshot))
    }
  }

  func getTimeline(
    in context: Context,
    completion: @escaping (Timeline<WidgetFeature.Entry>) -> Void
  ) {
    Task {
      await self.store.send(.timelineProviderRequestsTimeline(context)).finish()
      completion(self.store.withState(\.timeline))
    }
  }

  init(store: StoreOf<WidgetFeature>) {
    self.store = store
  }

  private let store: StoreOf<WidgetFeature>
}

struct MetronomeWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(
      kind: self.kind,
      provider: MetronomeWidgetTimelineProvider(store: self.store)
    ) { entry in
      WidgetView(entry: entry)
    }
    .supportedFamilies(WidgetConfig.supportedFamilies)
  }

  private let kind = "MetronomeWidget"
  private let store = Store(
    initialState: WidgetFeature.State()
  ) {
    WidgetFeature()
  } withDependencies: {
    $0.userDefaults = .appGroup
  }
}
