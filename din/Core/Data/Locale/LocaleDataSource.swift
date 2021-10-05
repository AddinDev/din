//
//  LocaleDataSource.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation

protocol LocaleDataSourceProtocol {
  
}

final class LocaleDataSource {
  
  init() { }
  
  static let sharedInstance: LocaleDataSource = LocaleDataSource()
  
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
}
