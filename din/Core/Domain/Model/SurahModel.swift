//
//  SurahModel.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

typealias SurahModels = [SurahModel]

struct SurahModel: Identifiable {
  let id: Int
  let place: String
  let order: Int
  let bismillahPre: Bool
  let nameSimple, nameComplex, nameArabic: String
  let versesCount: Int
  let pages: [Int]
}
