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
        .lineLimit(3)
      Text(hadits.source)
        .font(.callout)
        .foregroundColor(.gray)
    }
    .frame(width: UIScreen.main.bounds.width - 50)
    .padding(.vertical, 10)
    .padding(.leading, 14)
  }
}
