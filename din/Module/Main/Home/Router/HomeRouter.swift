//
//  HomeRouter.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import SwiftUI

struct HomeRouter {
  
  func makeDetailView(news: NewsModel) -> some View {
    let useCase = Injection.init().provideNewsDetail()
    let presenter = NewsDetailPresenter(useCase: useCase, news: news)
    return NewsDetailView(presenter: presenter)
  }
  
}
