//
//  Api.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

struct Api {
  
  static let quranApi = "https://api.quran.com/api/v4/chapters"
  
  static func surahApi(id: Int) -> String {
    return "http://api.alquran.cloud/v1/surah/\(id)/editions/quran-uthmani,id.indonesian"
  }

  static let newsApi = "https://newsapi.org/v2/everything?q=islam&sortBy=popularity&apiKey=f4fc7afbfa8d42538ff983705b707eae"
  
  static let haditsBookApi = "https://api.hadith.sutanlab.id/books"
  
  static func haditsApi(name: String, _ first: Int, _ end: Int) -> String {
    return "https://api.hadith.sutanlab.id/books/\(name)?range=\(first)-\(end)"
  }
  
  static func adzanApi(lat: Float, long: Float) -> String {
    return "http://api.aladhan.com/v1/calendar?latitude=\(lat)&longitude=\(long)&method=2"
  }
  
//  static func haditsApi(type: HaditsType, id: Int) -> String {
//    return "http://api.carihadis.com/?kitab=\(type.rawValue)&id=\(id)"
//  }
  
}
