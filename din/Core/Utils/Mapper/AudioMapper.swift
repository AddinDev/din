//
//  AudioMapper.swift
//  din
//
//  Created by Addin Satria on 08/11/21.
//

import Foundation

class AudioMapper {
  
  static func responsesToModels(_ responses: AudioResponses) -> AudioModels {
    return responses.map { response in
      return AudioModel(title: response.fields.title.stringValue, author: response.fields.author.stringValue, date: response.createTime, description: response.fields.desc.stringValue, file: response.fields.audio.stringValue, cover: response.fields.cover.stringValue)
    }
  }
  
}
