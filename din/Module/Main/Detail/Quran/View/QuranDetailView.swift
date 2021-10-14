//
//  QuranDetailView.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import SwiftUI

struct QuranDetailView: View {
  
  @ObservedObject var presenter: QuranDetailPresenter
  
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
    .navigationTitle(presenter.surah.nameSimple)
    .navigationBarTitleDisplayMode(.inline)
    .animation(.linear)
    .onAppear {
      if presenter.ayahs.count == 0 {
        presenter.fetchAyahs()
      }
    }
  }
}

extension QuranDetailView {
  
  var content: some View {
    List(presenter.ayahs) { ayah in
      VStack(alignment: .leading) {
        Text(ayah.arab)
          .multilineTextAlignment(.trailing)
        Text(ayah.text)
      }
    }
    .listStyle(PlainListStyle())
  }
  
}
