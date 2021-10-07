//
//  HomeView.swift
//  din
//
//  Created by Addin Satria on 05/10/21.
//

import SwiftUI

struct HomeView: View {
  private let prayers = ["Subuh", "Dzuhur", "Ashar", "Maghrib", "Isya"]
    var body: some View {
      VStack {
        prayerTime
      }
    }
}

extension HomeView {
  
  var prayerTime: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("11 45")
          .font(.largeTitle)
          .fontWeight(.medium)
        Text("Dzuhur")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.gray)
      }
      VStack {
        ForEach(prayers, id: \.self) { prayer in
          Text(prayer)
        }
      }
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
