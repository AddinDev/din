//
//  SurahMapper.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

class SurahMapper {
  
  static func responsesToModels(_ surahs: SurahResponses) -> SurahModels {
    return surahs.map { surah in
      return SurahModel(id: surah.id, place: surah.revelationPlace.rawValue, order: surah.revelationOrder, bismillahPre: surah.bismillahPre, nameSimple: surah.nameSimple, nameComplex: surah.nameComplex, nameArabic: surah.nameArabic, versesCount: surah.versesCount, pages: surah.pages)
    }
  }
  
  static func ayahsResponseToModels(_ ayahs: [String: AyahResponses]) -> AyahModels {
    var ayahContainer: AyahModels = []
    if let id = ayahs["id"], let ar = ayahs["ar"] {
      for i in 0..<id.count {
        let ayah = AyahModel(id: id[i].numberInSurah, text: id[i].text, arab: ar[i].text)
        ayahContainer.append(ayah)
      }
    }
    return ayahContainer
  }
  
}
