//
//  Api.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

struct Api {
  
  static let quranApi = "https://api.quran.com/api/v4/chapters"
//  static let randomAyahApi =
  static let newsApi = "https://newsapi.org/v2/everything?q=islam&sortBy=popularity&apiKey=f4fc7afbfa8d42538ff983705b707eae"
  
  static let haditsBookApi = "https://api.hadith.sutanlab.id/books"
  
  static func adzanApi(lat: Float, long: Float) -> String {
    return "http://api.aladhan.com/v1/calendar?latitude=\(lat)&longitude=\(long)&method=2"
  }
  
//  static func haditsApi(type: HaditsType, id: Int) -> String {
//    return "http://api.carihadis.com/?kitab=\(type.rawValue)&id=\(id)"
//  }
  
}

enum HaditsType: String {
  case shahih_bukhori = "Shahih_Bukhari"
  case arbain1 = "Arbain_Nawawi_I"
  case arbain2 = "Arbain_Nawawi_II"
}
