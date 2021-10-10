//
//  HaditsMapper.swift
//  din
//
//  Created by Addin Satria on 09/10/21.
//

import Foundation

class HaditsMapper {
  
  static func bookResponsesToModels(_ responses: HaditsNameResponses) -> HaditsNameModels {
    return responses.map { hadits in
      return HaditsNameModel(id: hadits.id, name: hadits.name, available: hadits.available)
    }
  }
  
  static func responsesToModels( _ responses: HaditsResponses) -> HaditsModels {
    return responses.map { hadits in
      return HaditsModel(id: hadits.number, text: hadits.id, arabic: hadits.arab)
    }
  }
  
}
