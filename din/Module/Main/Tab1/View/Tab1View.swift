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
    Group {
      if presenter.quranLoading {
        LoadingIndicator()
      } else if presenter.quranError {
        ErrorIndicator(message: presenter.quranErrorMessage)
      } else {
        content
      }
    }
    .transition(.slide)
    .animation(.spring())
    .onAppear {
      if presenter.surahs.count == 0 {
        presenter.fetchSurahs()
      }
    }
  }
}

extension Tab1View {
  
  var content: some View {
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
        TabView(selection: $selected) {
          quran
            .tag(0)
          hadits
            .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page)
      }
    }
  }
  
  var quran: some View {
    List {
      HStack {
        Spacer()
        Menu {
//          Button("Sort") { print("sorted") }
          Menu {
            Button("Place") { print("sorted") }
            Button("Time") { print("sorted") }
          } label: {
            Text("Sort")
          }
        } label: {
          Text("Edit")
        }
      }
      ForEach(presenter.surahs) { surah in
        Tab1SurahListView(surah: surah)
          .contextMenu {
            Button(action: {
              print("downloaded")
            }) {
              Label("Download", systemImage: "cloud")
            }
          }
      }
    }
    .listStyle(PlainListStyle())
  }
  
  var hadits: some View {
    VStack {
      Text("Hadits")
      Spacer()
    }
  }
  
}
