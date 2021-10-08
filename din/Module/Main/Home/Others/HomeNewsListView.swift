//
//  HomeNewsListView.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeNewsListView: View {
  var news: NewsModel
  var body: some View {
    VStack(alignment: .leading) {
      Group {
        if let image = URL(string: news.image) {
          WebImage(url: image)
            .resizable()
            .placeholder(Image("default-image").resizable())
        }
      }
      .frame(height: 200)
//      .cornerRadius(15)
      .scaledToFit()
//      .shadow(color: .gray.opacity(0.5), radius: 5, x: 5, y: 5)
      
      VStack(alignment: .leading) {
        Text(news.title)
          .lineLimit(2)
          .padding(.vertical, 5)
        HStack {
          Text(news.source)
          Spacer()
          Text(news.published)
        }
      }
      .font(.subheadline)
      .padding(.horizontal, 5)
    }
    .foregroundColor(.primary)
    .padding(10)
//    .background(BlurEffectView(style: .regular))
    .cornerRadius(15)
    .padding(.horizontal, 10)
  }
}

struct HomeNewsListView_Previews: PreviewProvider {
  static var previews: some View {
    HomeNewsListView(news: NewsModel(source: "udin", author: "udin", title: "udin", desc: "udin", url: "", image: "", published: "11 April", content: "udin"))
  }
}
