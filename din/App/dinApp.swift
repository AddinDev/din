//
//  dinApp.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI
import AVFoundation

@main
struct din: App {
  var body: some Scene {
    
    let homeUseCase = Injection.init().provideHome()
    let homePresenter = HomePresenter(useCase: homeUseCase)
    
    let tab1UseCase = Injection.init().provideTab1()
    let tab1Presenter = Tab1Presenter(useCase: tab1UseCase)
    
    let tab3UseCase = Injection.init().provideTab3()
    let tab3Presenter = Tab3Presenter(useCase: tab3UseCase)
    
    let audioSession = AVAudioSession.sharedInstance()
    
    WindowGroup {
      ContentView()
        .environmentObject(SystemPreference())
        .environmentObject(homePresenter)
        .environmentObject(tab1Presenter)
        .environmentObject(tab3Presenter)
        .onAppear {
          do {
              try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
          } catch let error as NSError {
              print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
          }
        }
    }
    
  }
}
