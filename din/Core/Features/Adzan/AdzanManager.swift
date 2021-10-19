//
//  AdzanManager.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation
import CoreLocation
import UserNotifications

class AdzanManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var authorizationStatus: CLAuthorizationStatus
  @Published var lastSeenLocation: CLLocation?
  @Published var currentPlacemark: CLPlacemark?
  
  private let locationManager: CLLocationManager
  
  override init() {
    locationManager = CLLocationManager()
    authorizationStatus = locationManager.authorizationStatus
    
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 0.4
    locationManager.startUpdatingLocation()
  }
  
  func requestLocationPermission() {
    print("TASK: request permission")
    locationManager.requestWhenInUseAuthorization()
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    authorizationStatus = manager.authorizationStatus
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    lastSeenLocation = locations.first
//    print("latitude: \(lastSeenLocation?.coordinate.latitude ?? 0)")
//    print("longitude: \(lastSeenLocation?.coordinate.longitude ?? 0)")
    fetchCountryAndCity(for: locations.first)
  }
  
  func fetchCountryAndCity(for location: CLLocation?) {
    guard let location = location else { return }
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      if let error = error {
        print("TASKERROR: \(error)")
      } else {
        self.currentPlacemark = placemarks?.first
//        print("TASK: location: \(self.currentPlacemark?.locality ?? "")")
      }
    }
  }
  
  // notification
  func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
      if success {
        print("TASK: permission permitted")
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
  }
  
}
