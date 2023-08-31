import ActivityClient
import Dependencies
import WidgetActivityAttributes

extension DependencyValues {
  public var widgetLiveActivity: ActivityClient<WidgetActivityAttributes> {
    get { self[ActivityClient<WidgetActivityAttributes>.self] }
    set { self[ActivityClient<WidgetActivityAttributes>.self] = newValue }
  }
}
