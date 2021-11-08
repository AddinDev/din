//
//  HaditsDetailView.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import SwiftUI
import MobileCoreServices

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
        .contextMenu {
          Button(action: {
            UIPasteboard
              .general
              .setValue(hadits.text,
                        forPasteboardType: kUTTypePlainText as String)
          }) {
            Text("Copy to clipboard")
            Image(systemName: "doc.on.doc")
          }
        }
    }
    .listStyle(PlainListStyle())
  }
  
}
