//
//  Repository.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import Combine

protocol RepositoryProtocol {
  
}

final class Repository {
  
  typealias Repo = (RemoteDataSourceProtocol, LocaleDataSourceProtocol) -> Repository
  
  fileprivate var remote: RemoteDataSourceProtocol
  fileprivate var locale: LocaleDataSourceProtocol
  
  init(remote: RemoteDataSourceProtocol, locale: LocaleDataSourceProtocol) {
    self.remote = remote
    self.locale = locale
  }
  
  static let sharedInstance: Repo = { remote, locale in
    return Repository(remote: remote, locale: locale)
  }
  
}

extension Repository: RepositoryProtocol {
  
}
