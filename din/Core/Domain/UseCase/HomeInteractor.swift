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
  func fetchAdzan(lat: Float, long: Float) -> AnyPublisher<AdzanModels, Error>
//  func fetchHadits() -> AnyPublisher<HaditsModels, Error>
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
  
  func fetchAdzan(lat: Float, long: Float) -> AnyPublisher<AdzanModels, Error> {
    self.repository.fetchAdzan(lat: lat, long: long)
  }
  
//  func fetchHadits() -> AnyPublisher<HaditsModels, Error> {
//    self.repository.fet()
//  }
  
}
