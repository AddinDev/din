//
//  HaditsDetailInteractor.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import Foundation
import Combine

protocol HaditsDetailUseCase {
  func fetchHadits(_ name: String, _ first: Int, _ end: Int) -> AnyPublisher<HaditsModels, Error>
}

class HaditsDetailInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension HaditsDetailInteractor: HaditsDetailUseCase {
  func fetchHadits(_ name: String, _ first: Int, _ end: Int) -> AnyPublisher<HaditsModels, Error> {
    self.repository.fetchHadits(name, first, end)
  }
}
