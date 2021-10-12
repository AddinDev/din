//
//  QuranDetailPresenter.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import Combine

// func fetchAyah(id: Int) -> AnyPublisher<AyahModels, Error>

class QuranDetailPresenter: ObservableObject {
  
  private let useCase: QuranDetailUseCase
  
  private var cancellables: Set<AnyCancellable> = []
    
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var ayahs: AyahModels = []
  
  let surah: SurahModel
  
  init(useCase: QuranDetailUseCase, surah: SurahModel) {
    self.useCase = useCase
    self.surah = surah
  }
  
  func fetchAyahs() {
    self.isLoading = true
    self.useCase.fetchAyah(id: surah.id)
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
      } receiveValue: { ayahs in
        DispatchQueue.main.async {
          self.ayahs = ayahs
        }
      }
      .store(in: &cancellables)
  }
}
