//
//  SettingsView.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    List {
      Section(
        header: Text("Support the Developers"),
        footer: Text("Thanks for your support :)")
      ) {
        shareButton
        donateButton
      }
    }
  }
}

extension SettingsView {
  
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
