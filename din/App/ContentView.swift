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
        NavigationView {
        HomeView(presenter: homePresenter)
        }
          .tabItem {
            Image(systemName: "circle.bottomthird.split")
          }
          .tag(0)
        NavigationView {
        Tab1View(presenter: tab1Presenter)
        }
          .tabItem {
            Image(systemName: "circlebadge.2.fill")
          }
          .tag(1)
        Text("Dzikir Doa Harian")
          .tabItem {
            Image(systemName: "helm")
          }
          .tag(2)
        Tab3View()
          .tabItem {
            Image(systemName: "headphones")
          }
          .tag(3)
        SettingsView()
          .tabItem {
            Image(systemName: "gear") // circle.lefthalf.fill  helm
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
