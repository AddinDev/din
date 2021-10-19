//
//  Tab2Presenter.swift
//  din
//
//  Created by Addin Satria on 14/10/21.
//

import SwiftUI
import Combine

class Tab2Presenter: ObservableObject {
  
//  private let router = Tab2Router
  
  private let useCase: Tab2UseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(useCase: Tab2UseCase) {
    self.useCase = useCase
  }
  
}
