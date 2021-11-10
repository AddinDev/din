//
//  Tab3Presenter.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import Combine
import AVFoundation
import MediaPlayer

class Tab3Presenter: AudioPlayer {
  
  //  private let router = Tab3Router()
  
  private let useCase: Tab3UseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var audios: AudioModels = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
    
  init(useCase: Tab3UseCase) {
    self.useCase = useCase
  }
  
  func fetchAudio() {
    self.isLoading = true
    self.useCase.fetchAudio()
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
      } receiveValue: { audios in
        self.audios = audios
      }
      .store(in: &cancellables)
  }
  
}
