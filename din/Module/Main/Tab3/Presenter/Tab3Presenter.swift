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
  
  var audioUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/alpa-5e940.appspot.com/o/ALLAH%20AKAN%20GANTI.mp3?alt=media&token=2dcd5a6b-1da6-4112-93ef-0bdab00b0b67")
  
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
