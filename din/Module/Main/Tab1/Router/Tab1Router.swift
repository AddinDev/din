//
//  Tab1Router.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import SwiftUI

struct Tab1Router {
  
  func makeDetailView(_ haditsBook: HaditsNameModel, _ first: Int, _ end: Int) -> some View {
    let useCase = Injection.init().provideHaditsDetail()
    let presenter = HaditsDetailPresenter(useCase: useCase, haditsBook, first, end)
    return HaditsDetailView(presenter: presenter)
  }
  
}
