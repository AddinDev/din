//
//  AdzanMapper.swift
//  din
//
//  Created by Addin Satria on 09/10/21.
//

import Foundation

class AdzanMapper {
  
  static func responsesToModels(_ responses: AdzanResponses) -> AdzanModels {
    return responses.map { adzan in
      return AdzanModel(imsak: adzan.timings.imsak, subuh: adzan.timings.fajr, terbit: adzan.timings.sunrise, dzuhur: adzan.timings.dhuhr, ashar: adzan.timings.asr, magrib: adzan.timings.maghrib, terbenam: adzan.timings.sunset, isya: adzan.timings.isha)
    }
  }
  
}
