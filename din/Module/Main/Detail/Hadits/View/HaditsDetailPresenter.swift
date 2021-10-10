//
//  HaditsDetailPresenter.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import Foundation
import Combine

class HaditsDetailPresenter: ObservableObject {
  
  private let useCase: HaditsDetailUseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  var haditsBook: HaditsNameModel
  private var first: Int
  private var end: Int
    
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var hadits: HaditsModels = []
  
  init(useCase: HaditsDetailUseCase, _ haditsBook: HaditsNameModel, _ first: Int, _ end: Int) {
    self.useCase = useCase
    self.haditsBook = haditsBook
    self.first = first
    self.end = end
  }
  
  func fetchHadits() {
    self.isLoading = true
    self.useCase.fetchHadits(haditsBook.id, first, end)
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
      } receiveValue: { hadits in
        DispatchQueue.main.async {
          self.hadits = hadits
        }
      }
      .store(in: &cancellables)
  }
}
