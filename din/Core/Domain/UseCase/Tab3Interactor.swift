//
//  Tab3Interactor.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import Combine

protocol Tab3UseCase {
}

class Tab3Interactor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension Tab3Interactor: Tab3UseCase {
  
}
