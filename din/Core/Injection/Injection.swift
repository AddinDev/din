//
//  Injection.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation

final class Injection {
  
  private func provideRepository() -> Repository {
    let remote = RemoteDataSource.sharedInstance
    let locale = LocaleDataSource.sharedInstance
    return Repository.sharedInstance(remote, locale)
  }
  
}
