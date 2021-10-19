//
//  SettingsView.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI

struct SettingsView: View {
  @ObservedObject var adzanManager = AdzanManager()
  var body: some View {
    List {
      Section(
        header: Text("App Info"),
        footer: EmptyView()
      ) {
        appVersion
        appResources
      }
      Section(header: Text("App Settings"),
              footer: EmptyView()
      ) {
        locationAuthButton
      }
      Section(
        header: Text("Support the Developers"),
        footer: Text("Thanks for your support :)")
      ) {
        shareButton
        donateButton
      }
    }
    .navigationTitle("")
    .navigationBarHidden(true)
  }
}

extension SettingsView {
  
  var locationAuthButton: some View {
    Group {
      switch adzanManager.authorizationStatus {
        case .authorized:
          HStack {
            Text("Location")
            Spacer()
            Text("Authorized")
              .foregroundColor(.green)
          }
        case .authorizedWhenInUse:
          HStack {
            Text("Location")
            Spacer()
            Text("Authorized")
              .foregroundColor(.green)
          }
        case .authorizedAlways:
          HStack {
            Text("Location")
            Spacer()
            Text("Authorized")
              .foregroundColor(.green)
          }
        default:
          Button(action: {
            adzanManager.requestLocationPermission()
          }) {
            HStack {
              Text("Location")
                .foregroundColor(.primary)
              Spacer()
              Text("Not Authorized")
                .foregroundColor(.red)
            }
          }
      }
    }
  }
  
  var appVersion: some View {
    HStack {
      Text("App Version")
      Spacer()
      Text("Alpha 1.0")
    }
  }
  
  var appResources: some View {
    DisclosureGroup("Resources") {
      Text("Item 1")
      Text("Item 2")
      Text("Item 3")
    }
  }
  
  var shareButton: some View {
    Button(action: {
      share(items: [URL(string: "https://google.com")!])
    }) {
      Text("Share the app")
    }
  }
  
  var donateButton: some View {
    Button(action: {
      UIApplication.shared.open(URL(string: "https://saweria.co/udinda")!)
    }) {
      Text("Donate")
    }
  }
  
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
