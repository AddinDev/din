//
//  QuranDetailInteractor.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import Combine

protocol QuranDetailUseCase {
  func fetchAyah(id: Int) -> AnyPublisher<AyahModels, Error>
}

class QuranDetailInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension QuranDetailInteractor: QuranDetailUseCase {
  
  func fetchAyah(id: Int) -> AnyPublisher<AyahModels, Error> {
    self.repository.fetchAyah(id: id)
  }
  
}
