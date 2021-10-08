//
//  Tab1Presenter.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI
import Combine

class Tab1Presenter: ObservableObject {
  
  private let useCase: Tab1UseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var quranLoading = false
  @Published var quranError = false
  @Published var quranErrorMessage = ""
  
  @Published var haditsLoading = false
  @Published var haditsError = false
  @Published var haditsErrorMessage = ""
  
  @Published var surahs: SurahModels = []
  
  init(useCase: Tab1UseCase) {
    self.useCase = useCase
  }
  
  func fetchSurahs() {
    self.quranLoading = true
    self.useCase.fetchSurahs()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.quranLoading = false
          case .failure(let error):
            self.quranErrorMessage = error.localizedDescription
            self.quranError = true
            self.quranLoading = false
        }
      } receiveValue: { surahs in
        DispatchQueue.main.async {
          self.surahs = surahs
        }
      }
      .store(in: &cancellables)
  }
  
}
