//
//  NewsDetailInteractor.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import Foundation
import Combine

protocol NewsDetailUseCase {
  
}

class NewsDetailInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension NewsDetailInteractor: NewsDetailUseCase {
  
}
