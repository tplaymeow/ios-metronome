import SwiftUI
import WidgetKit

@main
struct WidgetBundle: SwiftUI.WidgetBundle {
  var body: some Widget {
    MetronomeWidget()
    MetronomeWidgetLiveActivity()
  }
}
