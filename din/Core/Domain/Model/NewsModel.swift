//
//  NewsModel.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import Foundation

typealias NewsModels = [NewsModel]

struct NewsModel: Identifiable {
  let id = UUID().uuidString
  let source: String
  let author: String?
  let title: String
  let desc: String
  let url: String
  let image: String
  let published: String
  let content: String
}
