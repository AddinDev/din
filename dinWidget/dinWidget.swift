//
//  dinWidget.swift
//  dinWidget
//
//  Created by Addin Satria on 19/10/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry()
  }
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let entry = SimpleEntry()
    completion(entry)
  }
  func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
    let entry = SimpleEntry()
    let entries: [SimpleEntry] = [entry]
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date = Date()
}

struct dinWidgetEntryView: View {
  var entry: Provider.Entry
  
  @Environment(\.widgetFamily) var size
  
  @ViewBuilder
  var body: some View {
    switch size {
      case .systemSmall:
          VStack(alignment: .leading) {
            Text("11 45")
              .font(.system(size: 60))
              .fontWeight(.medium)
            Text("Dzuhur")
              .font(.title)
              .fontWeight(.semibold)
              .foregroundColor(.gray)
          }
      case .systemMedium:
        VStack {
          Text(entry.date, style: .time)
            .font(.title)
          Text("Ingat Kematian.")
            .font(.headline)
            .foregroundColor(.gray)
        }
      default:
        VStack {
          Text(entry.date, style: .time)
            .font(.title)
          Text("Ingat Kematian.")
            .font(.headline)
            .foregroundColor(.gray)
        }
    }
  }
}

@main
struct dinWidget: Widget {
  let kind: String = "dinWidget"
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind,
                        provider: Provider(),
                        content: { entry in
      dinWidgetEntryView(entry: entry)
    })
      .configurationDisplayName("din Widget")
      .description("This is an example widget.")
      .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
  }
}

struct dinWidget_Previews: PreviewProvider {
  static var previews: some View {
    dinWidgetEntryView(entry: SimpleEntry())
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
