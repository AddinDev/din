//
//  AdzanManager.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation
import CoreLocation

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
  
  func requestPermission() {
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
        print("error: \(error)")
      } else {
        self.currentPlacemark = placemarks?.first
        print("location: \(self.currentPlacemark?.locality ?? "")")
      }
    }
  }
}
