//
//  GlobalHelper.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI

// sharing feature
@discardableResult
func share(
    items: [Any],
    excludedActivityTypes: [UIActivity.ActivityType]? = nil
) -> Bool {
    guard let source = UIApplication.shared.windows.last?.rootViewController else {
        return false
    }
    let vc = UIActivityViewController(
        activityItems: items,
        applicationActivities: nil
    )
    vc.excludedActivityTypes = excludedActivityTypes
    vc.popoverPresentationController?.sourceView = source.view
    source.present(vc, animated: true)
    return true
}

struct LoadingIndicator: View {
  var body: some View {
    VStack {
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
      Text("Loading...")
    }
  }
}

struct ErrorIndicator: View {
  var message: String
  var body: some View {
    VStack {
      Text("ERROR")
      Text(message)
    }
    .padding()
  }
}

let prayerNames = ["Subuh", "Dzuhur", "Ashar", "Maghrib", "Isya"]
