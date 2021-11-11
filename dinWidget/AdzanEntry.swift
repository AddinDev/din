//
//  AdzanEntry.swift
//  din
//
//  Created by Addin Satria on 11/11/21.
//

import Foundation
import WidgetKit

struct AdzanEntry: TimelineEntry {
  var date: Date
  var adzan: SubAdzanModels
}

extension AdzanEntry {
  
  static var placeholder: AdzanEntry {
    AdzanEntry(date: Date(), adzan: [
      SubAdzanModel(name: "Subuh", time: "04 45"),
      SubAdzanModel(name: "Dzuhur", time: "11 45"),
      SubAdzanModel(name: "Ashar", time: "14 45"),
      SubAdzanModel(name: "Maghrib", time: "17 45"),
      SubAdzanModel(name: "Isya", time: "18 45")
    ])
  }
  
  static func error(msg: String) -> AdzanEntry {
    AdzanEntry(date: Date(), adzan: [SubAdzanModel(name: "Error", time: msg)])
  }
  
}
