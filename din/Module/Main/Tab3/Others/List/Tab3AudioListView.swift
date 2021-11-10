//
//  Tab3AudioListView.swift
//  din
//
//  Created by Addin Satria on 10/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Tab3AudioListView: View {
  var audio: AudioModel
  var body: some View {
    HStack {
      WebImage(url: audio.coverURL)
        .resizable()
        .placeholder(
          Image("default-image")
            .resizable())
        .scaledToFill()
        .frame(width: 60, height: 60)
        .clipped()
        .padding(.vertical, 5)
      VStack(alignment: .leading) {
        Text(audio.title)
          .font(.subheadline)
        Text(audio.author)
          .font(.callout)
          .foregroundColor(.gray)
      }
      Spacer()
      Text("1 minute")
        .font(.caption)
        .foregroundColor(.gray)
    }
  }
}
