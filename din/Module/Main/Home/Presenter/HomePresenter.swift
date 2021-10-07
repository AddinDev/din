//
//  HomePresenter.swift
//  din
//
//  Created by Addin Satria on 06/10/21.
//

import SwiftUI
import Combine

class HomePresenter: AdzanManager {
  
  private let useCase: HomeUseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var surahs: SurahModels = []
  
  init(useCase: HomeUseCase) {
    self.useCase = useCase
  }
  
  func fetchSurahs() {
    self.isLoading = true
    self.useCase.fetchSurahs()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.isLoading = false
          case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isError = true
            self.isLoading = false
        }
      } receiveValue: { surahs in
        self.surahs = surahs
      }
      .store(in: &cancellables)
  }
  
}
