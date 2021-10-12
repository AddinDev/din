//
//  AudioResponse.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation

struct AudioResponse {
  let id = UUID().uuidString
  let title: String
  let description: String
  let file: String
}
