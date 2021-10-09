//
//  HomePresenter.swift
//  din
//
//  Created by Addin Satria on 06/10/21.
//

import SwiftUI
import Combine
import CoreLocation

class HomePresenter: AdzanManager {
  
  private let router = HomeRouter()
  
  private let useCase: HomeUseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var haditsLoading = false
  @Published var haditsError = false
  @Published var haditsErrorMessage = ""
  
  @Published var newsLoading = false
  @Published var newsError = false
  @Published var newsErrorMessage = ""
  
  @Published var adzanLoading = false
  @Published var adzanError = false
  @Published var adzanErrorMessage = ""
  
  @Published var adzan: [String] = []
  
  @Published var surahs: SurahModels = []
  
  @Published var news: NewsModels = []
  
  @Published var hadits: HaditsModels = []
  
  init(useCase: HomeUseCase) {
    self.useCase = useCase
  }
  
  override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if adzan.count == 0 {
    lastSeenLocation = locations.first
    fetchCountryAndCity(for: locations.first)
    fetchAdzan()
    }
  }
  
  func fetchNews() {
    self.newsLoading = true
    self.newsError = false
    self.useCase.fetchNews()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.newsLoading = false
          case .failure(let error):
            self.newsErrorMessage = error.localizedDescription
            self.newsError = true
            self.newsLoading = false
        }
      } receiveValue: { news in
        self.news = news
      }
      .store(in: &cancellables)
  }
  
//  func fetchHadits() {
//    self.haditsLoading = true
//    self.haditsError = false
//    self.useCase.fetchHadits()
//      .receive(on: RunLoop.main)
//      .sink { completion in
//        switch completion {
//          case .finished:
//            self.haditsLoading = false
//          case .failure(let error):
//            self.haditsErrorMessage = error.localizedDescription
//            self.haditsError = true
//            self.haditsLoading = false
//        }
//      } receiveValue: { hadits in
//        self.hadits = hadits
// //        print("hadits: \(self.hadits)")
//      }
//      .store(in: &cancellables)
//  }
  
  func fetchAdzan() {
    self.adzanLoading = true
    self.adzanError = false
    self.useCase.fetchAdzan(lat: Float(lastSeenLocation?.coordinate.latitude ?? 0),
                            long: Float(lastSeenLocation?.coordinate.longitude ?? 0))
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.adzanLoading = false
          case .failure(let error):
            self.adzanErrorMessage = error.localizedDescription
            self.adzanError = true
            self.adzanLoading = false
        }
      } receiveValue: { adzan in
        let todayAdzan = adzan[self.dayIndex()]
        let newAdzan = AdzanModel(imsak: self.splitMinuteAndHour(todayAdzan.imsak),
                                  subuh: self.splitMinuteAndHour(todayAdzan.subuh),
                                  terbit: self.splitMinuteAndHour(todayAdzan.terbit),
                                  dzuhur: self.splitMinuteAndHour(todayAdzan.dzuhur),
                                  ashar: self.splitMinuteAndHour(todayAdzan.ashar),
                                  magrib: self.splitMinuteAndHour(todayAdzan.magrib),
                                  terbenam: self.splitMinuteAndHour(todayAdzan.terbenam),
                                  isya: self.splitMinuteAndHour(todayAdzan.isya))
        self.adzan = [newAdzan.subuh, newAdzan.dzuhur, newAdzan.ashar, newAdzan.magrib, newAdzan.isya]
        print("adzan: \(self.adzan)")
      }
      .store(in: &cancellables)
  }
  
  private func splitMinuteAndHour(_ adzan: String) -> String {
    let time = adzan
    let r = time.index(time.startIndex, offsetBy: 0)..<time.index(time.endIndex, offsetBy: -9)
    let substring = String(time[r])
    let hour = substring.count == 1 ? ("0\(substring)") : substring

    let b = time.index(time.startIndex, offsetBy: 3)..<time.index(time.endIndex, offsetBy: -6)
    let c = time[b]
    let minute = c.count == 1 ? ("0\(c)") : c
    
    return "\(hour) \(minute)"
  }
  
  private func dayIndex() -> Int {
    let time = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "EEEE"
    let stringDate = timeFormatter.string(from: time)
    let dayIndex = Int(stringDate) ?? 1 - 1
    return dayIndex
  }
  
  func newsDetailLinkBuilder<Content: View>(for news: NewsModel, @ViewBuilder content: () -> Content ) -> some View {
    NavigationLink(destination: router.makeDetailView(news: news)) { content() }
  }
  
}
