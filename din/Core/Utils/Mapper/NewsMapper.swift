//
//  NewsMapper.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import Foundation

class NewsMapper {
  
  static func responsesToModels(_ responses: NewsResponses) -> NewsModels {
    return responses.map { news in
      return NewsModel(source: news.source.name, author: news.author ?? "unknown author", title: news.title, desc: news.articleDescription, url: news.url, image: news.urlToImage, published: formatDate(news.publishedAt), content: news.content)
    }
  }
  
  static func formatDate(_ date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "d MMM yyyy"
    
    if let date = dateFormatterGet.date(from: date) {
      return dateFormatterPrint.string(from: date)
    } else {
      print("There was an error decoding the string")
    }
    return "unknown"
  }
  
}
