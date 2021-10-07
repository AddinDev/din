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
  
    var body: some View {
      HomeView()
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
