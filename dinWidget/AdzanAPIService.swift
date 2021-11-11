//
//  AdzanAPIService.swift
//  din
//
//  Created by Addin Satria on 11/11/21.
//

import Foundation
import Alamofire
import CoreLocation

protocol AdzanAPIServiceProtocol {
  func fetchAdzan(completion: @escaping (Result<AdzanEntry, Error>) -> Void)
}

class AdzanAPIService: AdzanManager {
  
  var location: CLLocation?
  
  static let shared = AdzanAPIService()
  
  override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    location = locations.first
  }
  
}

extension AdzanAPIService: AdzanAPIServiceProtocol {
  
  func fetchAdzan(completion: @escaping (Result<AdzanEntry, Error>) -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      AF.request(Api.adzanApi(lat: Float(self.location?.coordinate.latitude ?? -6.21462),
                              long: Float(self.location?.coordinate.longitude ?? 106.84513)))
        .validate()
        .responseDecodable(of: PrayTimeResponse.self) { response in
          switch response.result {
            case .success(let value):
              let adzanResponse = value.data
              let adzanEntry = self.responsesToEntry(adzanResponse)
              completion(.success(adzanEntry))
            case .failure(let error):
              completion(.failure(error))
          }
        }
    }
  }
  
}

extension AdzanAPIService {
  
  private func dayIndex() -> Int {
    let time = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "EEEE"
    let stringDate = timeFormatter.string(from: time)
    let dayIndex = Int(stringDate) ?? 1 - 1
    return dayIndex
  }
  
  private func responsesToEntry(_ responses: AdzanResponses) -> AdzanEntry {
    let today = dayIndex()
    return AdzanEntry(date: Date(), adzan: [
      SubAdzanModel(name: "Subuh", time: splitMinuteAndHour(responses[today].timings.fajr)),
      SubAdzanModel(name: "Dzuhur", time: splitMinuteAndHour(responses[today].timings.dhuhr)),
      SubAdzanModel(name: "Ashar", time: splitMinuteAndHour(responses[today].timings.asr)),
      SubAdzanModel(name: "Maghrib", time: splitMinuteAndHour(responses[today].timings.maghrib)),
      SubAdzanModel(name: "Isya", time: splitMinuteAndHour(responses[today].timings.isha))
    ])
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
  
}
