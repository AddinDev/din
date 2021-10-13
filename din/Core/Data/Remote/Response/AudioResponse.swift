//
//  AudioResponse.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation

typealias AudioResponses = [AudioResponse]

struct AudioResponse {
  let title: String
  let image: String?
  let description: String
  let file: String
}