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
  
}
