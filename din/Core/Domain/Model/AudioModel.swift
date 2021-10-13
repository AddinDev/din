//
//  AudioModel.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation

typealias AudioModels = [AudioModel]

struct AudioModel {
  let id = UUID().uuidString
  let image: String?
  let title: String
  let description: String
  let file: String
}
