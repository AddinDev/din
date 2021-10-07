//
//  ContentView.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var systemPreference: SystemPreference
  
  @State var isShowBoardingScreen = false
  
  @State private var viewSelected = 0
  
    var body: some View {
      TabView(selection: $viewSelected) {
        HomeView()
          .tabItem {
            Image(systemName: "circle.bottomthird.split")
          }
          .tag(0)
        SettingsView()
          .tabItem {
            Image(systemName: "helm") // circle.lefthalf.fill  helm
          }
          .tag(1)
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
