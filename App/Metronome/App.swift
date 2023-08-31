import AppFeature
import ComposableArchitecture
import SwiftUI
import UserDefaultsDependency
import UserDefaultsExtensions

@main
struct MetronomeApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        AppView(store: self.store)
      }
      .onOpenURL { url in
        self.store.send(.openURL(url))
      }
    }
  }

  private let store = Store(
    initialState: AppFeature.State()
  ) {
    AppFeature()
  } withDependencies: {
    $0.userDefaults = .appGroup
  }
}
