//
//  HaditsDetailView.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import SwiftUI

struct HaditsDetailView: View {
  @ObservedObject var presenter: HaditsDetailPresenter
    var body: some View {
      Group {
        if presenter.isLoading {
          LoadingIndicator()
        } else if presenter.isError {
          ErrorIndicator(message: presenter.errorMessage)
        } else {
          content
        }
      }
      .navigationTitle(presenter.haditsBook.name)
      .navigationBarTitleDisplayMode(.inline)
      .animation(.linear)
      .onAppear {
          presenter.fetchHadits()
      }
    }
}

extension HaditsDetailView {
  
  var content: some View {
    List(presenter.hadits) { hadits in
        Text(hadits.text)
    }
    .listStyle(PlainListStyle())
  }
  
}
