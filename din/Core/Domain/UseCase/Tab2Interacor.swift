//
//  Tab2Interacor.swift
//  din
//
//  Created by Addin Satria on 14/10/21.
//

import Foundation
import Combine

protocol Tab2UseCase {
  
}

class Tab2Interactor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension Tab2Interactor: Tab2UseCase {
  
}
