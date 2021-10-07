//
//  Tab1View.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI

struct Tab1View: View {
  
  @ObservedObject var presenter: Tab1Presenter
  
  @State private var selected = 0
    
  var body: some View {
    VStack {
      HStack {
        Picker("Title", selection: $selected) {
          Text("Qur'an").tag(0)
          Text("Hadits").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 25)
        .padding(.vertical, 7)
      }
      Group {
        if selected == 0 {
          quran
        } else {
          hadits
        }
      }
    }
  }
}

extension Tab1View {
  
  var quran: some View {
    Group {
      if presenter.isLoading {
        LoadingIndicator()
      } else if presenter.isError {
        ErrorIndicator(message: presenter.errorMessage)
      } else {
        List(presenter.surahs) { surah in
          Tab1SurahListView(surah: surah)
        }
      }
    }
    .animation(.linear)
    .onAppear {
      if presenter.surahs.count == 0 {
        presenter.fetchSurahs()
      }
    }
  }
  
  var hadits: some View {
    Text("Hadits")
  }

}
