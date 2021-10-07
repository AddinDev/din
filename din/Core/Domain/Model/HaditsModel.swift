//
//  HaditsModel.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

struct HaditsModel: Identifiable {
  var id = UUID().uuidString
  var text: String
  var source: String
}
