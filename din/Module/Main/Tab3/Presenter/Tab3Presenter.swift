//
//  Tab3Presenter.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import Combine

class Tab3Presenter: ObservableObject {
  
//  private let router = Tab3Router()
  
  private let useCase: Tab3UseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage = ""
    
//  @Published var haditsName: HaditsNameModels = []
  
  init(useCase: Tab3UseCase) {
    self.useCase = useCase
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

