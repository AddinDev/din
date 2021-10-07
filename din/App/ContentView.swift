//
//  ContentView.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var systemPreference: SystemPreference
  
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var tab1Presenter: Tab1Presenter

  @State var isShowBoardingScreen = false
  
  @State private var viewSelected = 0
  
  var body: some View {
    TabView(selection: $viewSelected) {
      HomeView(presenter: homePresenter)
        .tabItem {
          Image(systemName: "circle.bottomthird.split")
        }
        .tag(0)
      Tab1View(presenter: tab1Presenter)
        .tabItem {
          Text("2")
        }
        .tag(1)
      Text("Dzikir Doa Harian")
        .tabItem {
          Text("3")
        }
        .tag(2)
      Text("Audio Book Video Terkait Keagamaan")
        .tabItem {
          Text("4")
        }
        .tag(3)
      SettingsView()
        .tabItem {
          Image(systemName: "helm") // circle.lefthalf.fill  helm
        }
        .tag(4)
    }
    .onAppear {
      if systemPreference.didBoarding == false {
        isShowBoardingScreen = true
      }
    }
    .sheet(isPresented: $isShowBoardingScreen) {
      systemPreference.doneBoarding()
    } content: {
      OnBoardingView(showState: $isShowBoardingScreen)
        .environmentObject(systemPreference)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
