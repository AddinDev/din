//
//  Tab2View.swift
//  din
//
//  Created by Addin Satria on 14/10/21.
//

import SwiftUI
import MapKit

struct Tab2View: View {
  var body: some View {
    ScrollView {
      VStack {
        CustomMapView()
          .frame(height: 250)
      }
    }
    .edgesIgnoringSafeArea(.top)
    .navigationTitle("")
    .navigationBarHidden(true)
  }
}

extension Tab2View {
  
  var content: some View {
    List {
      Text("Dzikir")
      Text("Doa")
      Text("Dzikir")
    }
    .listStyle(PlainListStyle())
  }
  
}

struct CustomMapView: View {
  @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 3.164557, longitude: 101.713423), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
  @State private var trackingMode = MapUserTrackingMode.follow
  @State private var locations: [Location] = Location.getLocation()
  
  var body: some View {
    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: locations) { (location) -> MapPin in
      MapPin(coordinate: location.coordinate, tint: .red)
    }  }
}

struct Location {
  let id = UUID()
  let title: String
  let coordinate: CLLocationCoordinate2D
}

extension Location: Identifiable { }

extension Location {
  static func getLocation() -> [Location] {
    return [
      Location(title: "KLCC Park", coordinate: CLLocationCoordinate2D(latitude: 3.155699, longitude: 101.713934)),
      Location(title: "Twin Tower", coordinate: CLLocationCoordinate2D(latitude: 3.157804, longitude: 101.711869))
    ]
  }
}

struct Tab2View_Previews: PreviewProvider {
  static var previews: some View {
    Tab2View()
  }
}
