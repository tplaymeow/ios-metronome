import WidgetKit
import SwiftUI

@main
struct WidgetBundle: SwiftUI.WidgetBundle {
  var body: some Widget {
    MetronomeWidget()
    MetronomeWidgetLiveActivity()
  }
}
