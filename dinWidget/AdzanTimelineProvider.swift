//
//  AdzanTimelineProvider.swift
//  din
//
//  Created by Addin Satria on 11/11/21.
//

import Foundation
import WidgetKit

struct AdzanTimelineProvider: TimelineProvider {
  
  let service = AdzanAPIService.shared
  
  func placeholder(in context: Context) -> AdzanEntry {
    AdzanEntry.placeholder
  }
  
  func getSnapshot(in context: Context, completion: @escaping (AdzanEntry) -> Void) {
    if context.isPreview {
      completion(AdzanEntry.placeholder)
    } else {
      fetchAdzan { result in
        switch result {
          case .success(let entry):
            completion(entry)
          case .failure:
            completion(AdzanEntry.placeholder)
        }
      }
    }
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<AdzanEntry>) -> Void) {
    fetchAdzan { result in
      switch result {
      case .success(let entry):
          // Refresh every 8 hrs
          let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 60 * 8)))
          completion(timeline)
      case .failure(let error):
          // Refresh after 2 mins
          let entry = AdzanEntry.error(msg: error.localizedDescription)
          let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 2)))
          completion(timeline)
      }
    }
  }
  
  private func fetchAdzan(completion: @escaping (Result<AdzanEntry, Error>) -> Void) {
    service.fetchAdzan { result in
      switch result {
        case .success(let entry):
          completion(.success(entry))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
}
