//
//  HaditsModel.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

struct HaditsNameModel: Identifiable {
  let id: String
  let name: String
  let available: Int
}

typealias HaditsNameModels = [HaditsNameModel]

typealias HaditsModels = [HaditsModel]

struct HaditsModel: Identifiable {
  var id: Int
  var text: String
  var arabic: String
}
