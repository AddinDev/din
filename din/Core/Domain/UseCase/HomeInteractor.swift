//
//  HomeInteractor.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import Combine

protocol HomeUseCase {
  func fetchSurahs() -> AnyPublisher<SurahModels, Error>
  func fetchNews() -> AnyPublisher<NewsModels, Error>
}

class HomeInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension HomeInteractor: HomeUseCase {
  
  func fetchSurahs() -> AnyPublisher<SurahModels, Error> {
    self.repository.fetchListofQuranChapters()
  }
  
  func fetchNews() -> AnyPublisher<NewsModels, Error> {
    self.repository.fetchNews()
  }
  
}
