//
//  HomeView.swift
//  din
//
//  Created by Addin Satria on 05/10/21.
//

import SwiftUI

struct HomeView: View {
  
  // dummy data, the real data is from API
  private let prayerNames = ["Subuh", "Dzuhur", "Ashar", "Maghrib", "Isya"]
  private let prayerTimes = ["04 45", "11 45", "14 45", "17 45", "18 45"]
  private let prayerNow: Int = 1
  
  var body: some View {
    ScrollView {
      VStack {
        placeAndDate
        prayerTime
        spacer
      }
    }
  }
}

extension HomeView {
  
  var spacer: some View {
    Spacer()
  }
  
  var placeAndDate: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(getDay())
        Text(getDate())
          .foregroundColor(.gray)
      }
      Spacer()
      Text("Jakarta Pusat")
    }
    .padding(.horizontal)
    .padding(.vertical, 7)
  }
  
  var prayerTime: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        Text(prayerTimes[prayerNow])
          .font(.system(size: 50))
          .fontWeight(.medium)
        Text(prayerNames[prayerNow])
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.gray)
      }
      HStack {
        VStack(alignment: .trailing) {
          ForEach(prayerTimes.filter { $0 != prayerTimes[prayerNow] }, id: \.self) { time in
            Text(time)
              .fontWeight(.medium)
          }
        }
        VStack(alignment: .leading) {
          ForEach(prayerNames.filter { $0 != prayerNames[prayerNow] }, id: \.self) { name in
            Text(name)
              .fontWeight(.semibold)
              .foregroundColor(.gray)
          }
        }
      }
      .padding(.horizontal)
    }
  }
  
  private func getDate() -> String {
    let time = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "d MMMM"
    let stringDate = timeFormatter.string(from: time)
    return stringDate
  }
  
  private func getDay() -> String {
    let time = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "EEEE"
    let stringDate = timeFormatter.string(from: time)
    return stringDate
  }
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
