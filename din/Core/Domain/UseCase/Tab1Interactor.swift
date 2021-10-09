//
//  Tab1Interactor.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation
import Combine

protocol Tab1UseCase {
  func fetchSurahs() -> AnyPublisher<SurahModels, Error>
  func fetchHaditsBook() -> AnyPublisher<HaditsNameModels, Error>
}

class Tab1Interactor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension Tab1Interactor: Tab1UseCase {
  
  func fetchSurahs() -> AnyPublisher<SurahModels, Error> {
    self.repository.fetchListofQuranChapters()
  }
  
  func fetchHaditsBook() -> AnyPublisher<HaditsNameModels, Error> {
    self.repository.fetchHaditsBook()
  }
  
}
