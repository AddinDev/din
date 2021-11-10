//
//  HomeView.swift
//  din
//
//  Created by Addin Satria on 05/10/21.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var presenter: HomePresenter
    
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
      //      presenter.setNotification(id: "1", title: "title", subtitle: nil, body: "hehe")
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
    .padding(.vertical, 7)
  }
  
  var prayerTime: some View {
    DisclosureGroup((presenter.adzan?[presenter.currentPrayerTime()].time ?? "") + " " + (presenter.adzan?[presenter.currentPrayerTime()].name ?? "")) {
      ForEach(presenter.adzan?.filter { $0.name != presenter.adzan?[presenter.currentPrayerTime()].name } ?? []) { prayer in
        Text("\(prayer.time) \(prayer.name)")
      }
    }
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
