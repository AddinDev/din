//
//  AdzanModel.swift
//  din
//
//  Created by Addin Satria on 09/10/21.
//

import Foundation

typealias AdzanModels = [AdzanModel]

struct AdzanModel: Identifiable {
  let id = UUID().uuidString
  let imsak: String
  let subuh: String
  let terbit: String
  let dzuhur: String
  let ashar: String
  let magrib: String
  let terbenam: String
  let isya: String
}
