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
    content
      .transition(.slide)
      .animation(.spring())
      .navigationTitle("")
      .navigationBarHidden(true)
  }
}

extension Tab1View {
  
  var content: some View {
    VStack {
      toggler
      TabView(selection: $selected) {
        quran
          .onAppear {
            if presenter.surahs.count == 0 {
              presenter.fetchSurahs()
            }
          }
          .tag(0)
        hadits
          .onAppear {
            if presenter.haditsName.count == 0 {
              presenter.fetchHaditsBook()
            }
          }
      }
      .tag(1)
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .indexViewStyle(.page)
  }
}

var toggler: some View {
  HStack {
    Picker("Title", selection: $selected) {
      Text("Qur'an").tag(0)
      Text("Hadits").tag(1)
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding(.horizontal, 25)
    .padding(.vertical, 7)
  }
}

var quran: some View {
  //    Group {
  //      if presenter.quranLoading {
  //        LoadingIndicator()
  //      } else if presenter.quranError {
  //        ErrorIndicator(message: presenter.quranErrorMessage)
  //      } else {
  List {
    HStack {
      Spacer()
      Menu {
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
      presenter.haditsDetailLinkBuilder(surah) {
        Tab1SurahListView(surah: surah)
          .contextMenu {
            Button(action: {
              print("downloaded")
            }) {
              Label("Download", systemImage: "icloud.and.arrow.down")
            }
          }
      }
    }
  }
  .listStyle(PlainListStyle())
  //      }
  //    }
}

var hadits: some View {
  List {
    if presenter.haditsLoading {
      LoadingIndicator()
    } else if presenter.haditsError {
      ErrorIndicator(message: presenter.haditsErrorMessage)
    } else {
      ForEach(presenter.haditsName) { hadits in
        presenter.haditsDetailLinkBuilder(hadits, 1, 5) {
          HStack {
            Text(hadits.name)
            Spacer()
            Text(String(hadits.available))
          }
        }
      }
    }
  }
  .listStyle(PlainListStyle())
}
}
