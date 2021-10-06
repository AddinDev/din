//
//  LocaleDataSource.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import Combine
import RealmSwift

protocol LocaleDataSourceProtocol {
  
}

final class LocaleDataSource {
  
  let realm: Realm?
  
  init(_ realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realm in
    return LocaleDataSource(realm)
  }
  
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
}
