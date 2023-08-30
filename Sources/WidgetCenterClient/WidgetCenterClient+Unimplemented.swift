extension WidgetCenterClient {
  public static var unimplemented: Self {
    .init(
      _implementation: .init(
        reloadAllTimelines: .unimplemented(
          #"@Dependency(\.widgetCenter.reloadAllTimelines)"#)
      )
    )
  }
}
