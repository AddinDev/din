//
//  AudioModel.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation

typealias AudioModels = [AudioModel]

struct AudioModel: Identifiable {
  let id = UUID().uuidString
  let title: String
  let author: String
  let date: String
  let description: String
  let file: String
  
  static func empty() -> AudioModel {
    AudioModel(title: "", author: "", date: "", description: "", file: "")
  }
}
