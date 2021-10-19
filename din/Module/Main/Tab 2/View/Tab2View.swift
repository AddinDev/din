//
//  Tab2View.swift
//  din
//
//  Created by Addin Satria on 14/10/21.
//

import SwiftUI

struct Tab2View: View {
    var body: some View {
        content
    }
}

extension Tab2View {
  
  var content: some View {
    List {
      Text("Dzikir")
      Text("Doa")
      Text("Dzikir")
    }
    .listStyle(PlainListStyle())
  }
  
}

struct Tab2View_Previews: PreviewProvider {
    static var previews: some View {
        Tab2View()
    }
}
