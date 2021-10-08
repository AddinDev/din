//
//  HomePresenter.swift
//  din
//
//  Created by Addin Satria on 06/10/21.
//

import SwiftUI
import Combine

class HomePresenter: AdzanManager {
  
  private let router = HomeRouter()
  
  private let useCase: HomeUseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var newsLoading = false
  @Published var newsError = false
  @Published var newsErrorMessage = ""
  
  @Published var surahs: SurahModels = []
  
  @Published var news: NewsModels = []
  
  init(useCase: HomeUseCase) {
    self.useCase = useCase
  }
  
  func fetchNews() {
    self.newsLoading = true
    self.newsError = false
    self.useCase.fetchNews()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.newsLoading = false
          case .failure(let error):
            self.newsErrorMessage = error.localizedDescription
            self.newsError = true
            self.newsLoading = false
        }
      } receiveValue: { news in
        self.news = news
      }
      .store(in: &cancellables)
  }
  
  func newsDetailLinkBuilder<Content: View>(for news: NewsModel, @ViewBuilder content: () -> Content ) -> some View {
    NavigationLink(destination: router.makeDetailView(news: news)) { content() }
  }
  
}
