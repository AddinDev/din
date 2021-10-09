//
//  HomeHaditsListView.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI

struct HomeHaditsListView: View {
  var hadits: HaditsModel
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("\"\(hadits.text)\"")
        .fontWeight(.medium)
        .lineLimit(3)
      Text("a")
        .font(.callout)
        .foregroundColor(.gray)
    }
    .frame(width: UIScreen.main.bounds.width - 50)
    .padding(.leading)
  }
}
