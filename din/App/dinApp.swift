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
    let homeUseCase = Injection.init().provideHome()
    let homePresenter = HomePresenter(useCase: homeUseCase)
    WindowGroup {
      ContentView()
        .environmentObject(SystemPreference())
        .environmentObject(homePresenter)
    }
  }
}
