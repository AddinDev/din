//
//  dinWidget.swift
//  dinWidget
//
//  Created by Addin Satria on 19/10/21.
//

import WidgetKit
import SwiftUI

@main
struct dinWidget: Widget {
  let kind: String = "dinWidget"
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind,
                        provider: AdzanTimelineProvider(),
                        content: { entry in
      AdzanWidgetView(entry: entry)
    })
      .configurationDisplayName("din Widget")
      .description("This is an example widget.")
      .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
  }
}

struct AdzanWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    AdzanWidgetView(entry: AdzanEntry.placeholder)
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
