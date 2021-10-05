//
//  HomeView.swift
//  din
//
//  Created by Addin Satria on 05/10/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
      List(0..<5) { i in
        Text("Dzuhur: \(i)")
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
