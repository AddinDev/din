//
//  dinApp.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI

@main
struct din: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(SystemPreference())
    }
  }
}
