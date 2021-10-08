//
//  Tab1SurahListView.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import SwiftUI

struct Tab1SurahListView: View {
  var surah: SurahModel
  var body: some View {
    HStack {
      Text(String(surah.id))
      VStack(alignment: .leading) {
        Text(surah.nameArabic)
        Text(surah.nameSimple)
          .foregroundColor(.gray)
      }
      Spacer()
      VStack(alignment: .trailing) {
        Text(surah.place)
        Text("\(surah.versesCount) verses")
//        Text("\(surah.pages[0])-\(surah.pages[1])")
      }
    }
  }
}

struct Tab1SurahListView_Previews: PreviewProvider {
  static var previews: some View {
    Tab1SurahListView(surah: SurahModel(id: 1, place: "a", order: 1, bismillahPre: false, nameSimple: "al fatihah", nameComplex: "al", nameArabic: "alfatihah", versesCount: 2, pages: [1, 7]))
  }
}
