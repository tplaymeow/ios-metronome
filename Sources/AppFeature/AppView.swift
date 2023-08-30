import SwiftUI
import ComposableArchitecture
import Design

public struct AppView: View {
  public var body: some View {
    VStack {
      Text(self.viewStore.titleText)
        .font(.system(size: 120.0))
        .padding()
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.Surface.secondary)
        .cornerRadius(16.0)

      Text(self.viewStore.tempoText)
        .font(.largeTitle)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.Surface.secondary)
        .cornerRadius(16.0)

      HStack {
        Button("➖") {
          self.viewStore.send(.decreaseTapped)
        }
        .padding()
        .background(Theme.Colors.Surface.secondary)
        .cornerRadius(16.0)

        Button(self.viewStore.startButtonText) {
          self.viewStore.send(.startButtonTapped)
        }
        .padding()
        .background(Theme.Colors.Surface.secondary)
        .cornerRadius(16.0)

        Button("➕") {
          self.viewStore.send(.increaseTapped)
        }
        .padding()
        .background(Theme.Colors.Surface.secondary)
        .cornerRadius(16.0)
      }
    }
    .fixedSize(horizontal: true, vertical: false)
    .background(Theme.Colors.Surface.primary)
    .alert(store: self.store.scope(state: \.$alert, action: AppFeature.Action.alert))
    .onAppear {
      self.viewStore.send(.onAppear)
    }
  }

  public init(store: StoreOf<AppFeature>) {
    self.store = store
    self.viewStore = ViewStore(
      store,
      observe: \.view,
      send: AppFeature.Action.view)
  }

  @ObservedObject
  private var viewStore: ViewStore<State, Action>
  private let store: StoreOf<AppFeature>
}
