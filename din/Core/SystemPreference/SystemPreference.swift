//
//  SystemPreference.swift
//  din
//
//  Created by Addin Satria on 06/10/21.
//

import Foundation

class SystemPreference: ObservableObject {
  
  @Published private var boarding = DataStore.shared.loadBoarding()
  
  var didBoarding: Bool {
    get {
      boarding.hasBoarding
    }
    set(newHasBoarding) {
      boarding.hasBoarding = newHasBoarding
    }
  }
  
}

extension SystemPreference {
  
  func doneBoarding() {
    self.boarding.hasBoarding = true
    DataStore.shared.doneBoarding(boarding)
//    super.reload()
  }
  
  func removeBoardingData() {
    self.boarding.hasBoarding = false
    DataStore.shared.removeBoardingData()
//    super.remove()
  }
  
}

struct Log: Codable {
  
  private var everBoarding: Bool = false
  
  var hasBoarding: Bool {
    get {
      return self.everBoarding
    }
    set(newBoarding) {
      self.everBoarding = newBoarding
    }
  }
}

struct DataStore {
  
  static let shared = DataStore()
  private let boardingKey = "din.boarding"
  
  func doneBoarding(_ user: Log) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(user) {
      let defaults = UserDefaults.standard
      defaults.set(encoded, forKey: boardingKey)
    }
  }
  
  func loadBoarding() -> Log {
    let defaults = UserDefaults.standard
    if let savedUser = defaults.object(forKey: boardingKey) as? Data {
      let decoder = JSONDecoder()
      if let loadedUser = try? decoder.decode(Log.self, from: savedUser) {
        return loadedUser
      }
    }
    return Log() // instantiate a new User and return
    // if it's not stored previously
  }
  
  func removeBoardingData() {
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: boardingKey)
  }
  
}
