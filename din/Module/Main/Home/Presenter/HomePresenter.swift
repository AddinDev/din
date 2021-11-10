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
  
  @Published var newsLoading = false
  @Published var newsError = false
  @Published var newsErrorMessage = ""
  
  @Published var adzanLoading = false
  @Published var adzanError = false
  @Published var adzanErrorMessage = ""
  
  @Published var adzan: [SubAdzanModel]?
  
  @Published var surahs: SurahModels = []
  
  @Published var news: NewsModels = []
  
  func filteredPrayers() -> [SubAdzanModel] {
    if let adzan = adzan {
      return adzan.filter { $0.name != adzan[currentPrayerTime()].name}
    }
    return []
  }
  
  init(useCase: HomeUseCase) {
    self.useCase = useCase
  }
  
  override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if adzan == nil {
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
        self.adzan = [
          SubAdzanModel(name: "Subuh", time: self.splitMinuteAndHour(todayAdzan.subuh)),
          SubAdzanModel(name: "Dzuhur", time: self.splitMinuteAndHour(todayAdzan.dzuhur)),
          SubAdzanModel(name: "Ashar", time: self.splitMinuteAndHour(todayAdzan.ashar)),
          SubAdzanModel(name: "Maghrib", time: self.splitMinuteAndHour(todayAdzan.magrib)),
          SubAdzanModel(name: "Isya", time: self.splitMinuteAndHour(todayAdzan.isya))
        ]
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
  
  func currentPrayerTime() -> Int {
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
  
  func newsDetailLinkBuilder<Content: View>(for news: NewsModel, @ViewBuilder content: () -> Content ) -> some View {
    NavigationLink(destination: router.makeDetailView(news: news)) { content() }
  }
  
  func setNotification(id: String, title: String, subtitle: String?, body: String) {
//    var dateComponents = DateComponents()
//    dateComponents.hour = hour
//    dateComponents.minute = minute
    
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let content = UNMutableNotificationContent()
    
    if let subtitle = subtitle {
      content.subtitle = subtitle
    }
    
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    
    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    print("set notification done")
  }
  
}

struct SubAdzanModel: Identifiable {
  let id = UUID().uuidString
  let name: String
  let time: String
}
