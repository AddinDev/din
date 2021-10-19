//
//  dinWidget.swift
//  dinWidget
//
//  Created by Addin Satria on 19/10/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(configuration: ConfigurationIntent())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(configuration: configuration)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    
    let entry = SimpleEntry(configuration: configuration)
    let entries: [SimpleEntry] = [entry]
  
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date = Date()
  let configuration: ConfigurationIntent
}

struct dinWidgetEntryView: View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      Text(entry.date, style: .time)
        .font(.title)
      Text("Ingat Kematian.")
        .font(.headline)
        .foregroundColor(.gray)
    }
  }
}

@main
struct dinWidget: Widget {
  let kind: String = "dinWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      dinWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}

struct dinWidget_Previews: PreviewProvider {
  static var previews: some View {
    dinWidgetEntryView(entry: SimpleEntry(configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
