//
//  Tab3Presenter.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import AVFoundation
import Combine

class Tab3Presenter: ObservableObject {
  
//  private let router = Tab3Router()
  
//  private let useCase: Tab3UseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
  
  @Published var player = AVPlayer()
  
  @Published var isPlaying = false
    
//  @Published var haditsName: HaditsNameModels = []
  
  init() {
//    self.useCase = useCase
//    self.play(URL(string: "https://firebasestorage.googleapis.com/v0/b/alpa-5e940.appspot.com/o/ALLAH%20AKAN%20GANTI.mp3?alt=media&token=2dcd5a6b-1da6-4112-93ef-0bdab00b0b67"))
  }
  
  func play(_ url: URL?) {
    if let url = url {
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
      } catch {
        print("TASKERROR AUDIO: \(error.localizedDescription)")
      }
      print("TASK AUDIO url: \(url)")
      player = AVPlayer(playerItem: AVPlayerItem(url: url))
      player.play()
      isPlaying = true
    }
  }
  
  func togglePlayer() {
    if isPlaying {
      player.pause()
    } else {
      player.play()
    }
    isPlaying.toggle()
  }
  
//  func fetchSurahs() {
//    self.quranLoading = true
//    self.useCase.fetchSurahs()
//      .receive(on: RunLoop.main)
//      .sink { completion in
//        switch completion {
//          case .finished:
//            self.quranLoading = false
//          case .failure(let error):
//            self.quranErrorMessage = error.localizedDescription
//            self.quranError = true
//            self.quranLoading = false
//        }
//      } receiveValue: { surahs in
//        DispatchQueue.main.async {
//          self.surahs = surahs
//        }
//      }
//      .store(in: &cancellables)
//  }
//
//  func haditsDetailLinkBuilder<Content: View>(_ bookName: HaditsNameModel, _ first: Int, _ end: Int, @ViewBuilder content: () -> Content ) -> some View {
//    NavigationLink(destination: router.makeHaditsDetailView(bookName, first, end)) { content() }
//  }

}
