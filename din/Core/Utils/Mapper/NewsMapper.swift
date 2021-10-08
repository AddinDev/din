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
      return NewsModel(source: news.source.name, author: news.author ?? "unknown author", title: news.title, desc: news.articleDescription, url: news.url, image: news.urlToImage, published: news.publishedAt, content: news.content)
    }
  }
  
}
