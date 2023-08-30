import WidgetKit

extension WidgetCenterClient {
  public static var shared: Self {
    .init(
      _implementation: .init(
        reloadAllTimelines: .init {
          WidgetCenter.shared.reloadAllTimelines()
        }
      )
    )
  }
}
