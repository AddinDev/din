//
//  NewsDetailView.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsDetailView: View {
  @ObservedObject var presenter: NewsDetailPresenter
  
    var body: some View {
      ScrollView(showsIndicators: false) {
        VStack {
          Group {
            if let image = URL(string: presenter.news.image) {
              WebImage(url: image)
                .resizable()
                .placeholder(Image("default-image").resizable())
            }
          }
          .frame(height: 200)
          .scaledToFit()
          .padding()
          VStack(alignment: .leading, spacing: 5) {
            HStack {
              Text(presenter.news.published)
              Spacer()
  //            Text(news.author)
            }
            Text(presenter.news.title)
              .font(.title2)
              .font(.callout)
            Text(presenter.news.desc)
              .font(.body)
              .padding(.vertical)
          }
          .padding(.horizontal)
        }
      }
      .navigationTitle(presenter.news.source)
      .navigationBarTitleDisplayMode(.inline)
    }
}
