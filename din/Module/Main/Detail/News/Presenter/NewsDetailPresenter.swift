//
//  NewsDetailPresenter.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import Foundation
import Combine

class NewsDetailPresenter: ObservableObject {
  
  private let useCase: NewsDetailUseCase
  
  let news: NewsModel
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  init(useCase: NewsDetailUseCase, news: NewsModel) {
    self.useCase = useCase
    self.news = news
  }
  
}
