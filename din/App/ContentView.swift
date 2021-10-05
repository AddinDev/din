//
//  ContentView.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI

struct ContentView: View {
  
  @State var isShowBoardingScreen = false
  
    var body: some View {
      HomeView()
        .onAppear {
          isShowBoardingScreen = true
        }
        .sheet(isPresented: $isShowBoardingScreen) {
          //
        } content: {
          OnBoardingView(showState: $isShowBoardingScreen)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
