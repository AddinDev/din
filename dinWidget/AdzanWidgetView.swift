//
//  AdzanWidgetView.swift
//  din
//
//  Created by Addin Satria on 11/11/21.
//

import SwiftUI
import WidgetKit

struct AdzanWidgetView: View {
  var entry: AdzanTimelineProvider.Entry
  
  @Environment(\.widgetFamily) var size
  
  @ViewBuilder
  var body: some View {
    if entry.adzan[0].name == "Error" {
      VStack {
      Text("ERROR")
        Text(entry.adzan[0].time)
      }
    } else {
    content
    }
  }
}

extension AdzanWidgetView {
  
  var content: some View {
    Group {
    switch size {
      case .systemSmall:
          VStack(alignment: .leading) {
            Text(entry.adzan[currentTime].time)
              .font(.system(size: 60))
              .fontWeight(.medium)
            Text(entry.adzan[currentTime].name)
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
  
  private var currentTime: Int {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let jam = Int(hour)
    if jam == 7 || jam == 8 || jam == 9 || jam == 10 || jam == 11 || jam == 12 || jam == 13 {
      return 1
    } else if jam == 14 || jam == 15 {
      return 2
    } else if jam == 16 || jam == 17 || jam == 18 {
      return 3
    } else if  jam == 19 || jam == 20 || jam == 21 || jam == 22 || jam == 23 {
      return 4
    } else {
      return 0
    }
  }
  
}
