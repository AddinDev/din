//
//  HomeView.swift
//  din
//
//  Created by Addin Satria on 05/10/21.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var presenter: HomePresenter
  
  // dummy data, the real data is from API
  private let prayerNames = ["Subuh", "Dzuhur", "Ashar", "Maghrib", "Isya"]
  private let prayerTimes = ["04 45", "11 45", "14 45", "17 45", "18 45"]
  private let prayerNow: Int = 1
  
  var body: some View {
       List {
        placeAndDate
        prayerTime
//        hadits
//        requestLocationPermissionButton
        news
      }
       .listStyle(PlainListStyle())
    .animation(.spring())
    .navigationTitle("")
    .navigationBarHidden(true)
    .onAppear {
//      DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//        presenter.fetchAdzan()
//      }
      if presenter.hadits.count == 0 {
//        presenter.fetchHadits()
      }
      if presenter.news.count == 0 {
        presenter.fetchNews()
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
      if let location = presenter.currentPlacemark?.locality {
        Text(location)
      } else {
        ProgressView()
      }
    }
//    .padding(.horizontal)
    .padding(.vertical, 7)
  }
  
  var prayerTime: some View {
//    HStack {
//      VStack(alignment: .leading, spacing: 0) {
//        Text(presenter.adzan.count == 0 ? "" : presenter.adzan[prayerNow])
//          .font(.system(size: 50))
//          .fontWeight(.medium)
//        Text(prayerNames[prayerNow])
//          .font(.title2)
//          .fontWeight(.semibold)
//          .foregroundColor(.gray)
//      }
//      HStack {
//        VStack(alignment: .trailing) {
//          ForEach(presenter.adzan.filter { $0 != (presenter.adzan.count == 0 ? "" : presenter.adzan[prayerNow]) }, id: \.self) { time in
//            Text(time)
//              .fontWeight(.medium)
//          }
//        }
//        VStack(alignment: .leading) {
//          ForEach(prayerNames.filter { $0 != prayerNames[prayerNow] }, id: \.self) { name in
//            Text(name)
//              .fontWeight(.semibold)
//              .foregroundColor(.gray)
//          }
//        }
//      }
//      .padding(.horizontal)
//    }
    DisclosureGroup("\(presenter.adzan.count == 0 ? "" : presenter.adzan[prayerNow]) \(prayerNames[prayerNow])") {
      
                ForEach(presenter.adzan.filter { $0 != (presenter.adzan.count == 0 ? "" : presenter.adzan[prayerNow]) }, id: \.self) { time in
                  Text(time)
//                    .fontWeight(.medium)
                }

    }
  }
  
  var hadits: some View {
    VStack {
      HStack {
        Spacer()
        Button(action: {
          print("open new screen")
        }) {
          Text("More")
          Image(systemName: "arrow.right") // chevron
        }
      }
      .padding(.trailing)
      ScrollView(.horizontal, showsIndicators: false) {
        ScrollViewReader { value in
        HStack {
          ForEach(presenter.hadits) { hadits in
            HomeHaditsListView(hadits: hadits)
              .id(hadits.id)
          }
        }
        .onAppear { withAnimation(.linear) { value.scrollTo(2, anchor: .center) } }
      }
      }
    }
    .padding(.vertical)
  }
  
  var news: some View {
    Group {
      if presenter.newsLoading {
        LoadingIndicator()
      } else if presenter.newsError {
        ErrorIndicator(message: presenter.newsErrorMessage)
      } else {
        ForEach(presenter.news) { news in
          presenter.newsDetailLinkBuilder(for: news) {
            HomeNewsListView(news: news)
          }
        }
      }
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
