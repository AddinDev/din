//
//  Tab1Presenter.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI
import Combine

class Tab1Presenter: ObservableObject {
  
  private let router = Tab1Router()
  
  private let useCase: Tab1UseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var quranLoading = false
  @Published var quranError = false
  @Published var quranErrorMessage = ""
  
  @Published var haditsLoading = false
  @Published var haditsError = false
  @Published var haditsErrorMessage = ""
  
  @Published var surahs: SurahModels = []
  
  @Published var haditsName: HaditsNameModels = []
  
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
  
  func fetchHaditsBook() {
    self.haditsLoading = true
    self.haditsError = false
    self.useCase.fetchHaditsBook()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
          case .finished:
            self.haditsLoading = false
          case .failure(let error):
            self.haditsErrorMessage = error.localizedDescription
            self.haditsError = true
            self.haditsLoading = false
        }
      } receiveValue: { haditsName in
        self.haditsName = haditsName
      }
      .store(in: &cancellables)
  }
  
  func haditsDetailLinkBuilder<Content: View>(_ bookName: HaditsNameModel, _ first: Int, _ end: Int, @ViewBuilder content: () -> Content ) -> some View {
    NavigationLink(destination: router.makeHaditsDetailView(bookName, first, end)) { content() }
  }
  
  func haditsDetailLinkBuilder<Content: View>(_ surah: SurahModel, @ViewBuilder content: () -> Content ) -> some View {
    NavigationLink(destination: router.makeQuranDetailView(surah)) { content() }
  }

}
