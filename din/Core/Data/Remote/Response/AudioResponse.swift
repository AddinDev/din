//
//  AudioResponse.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation

typealias AudioResponses = [AudioResponse]

// MARK: - AudioResponse
struct AudioResponseContainer: Codable {
  let documents: AudioResponses
}

// MARK: - Document
struct AudioResponse: Codable {
  let name: String
  let fields: Fields
  let createTime: String
}

// MARK: - Fields
struct Fields: Codable {
  let author, audio, title, desc: StringValue
}

// MARK: - Audio
struct StringValue: Codable {
  let stringValue: String
}

