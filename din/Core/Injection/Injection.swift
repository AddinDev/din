//
//  Injection.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import RealmSwift

final class Injection {
  
  private func provideRepository() -> Repository {
    let realm = try? Realm()
    let remote = RemoteDataSource.sharedInstance
    let locale = LocaleDataSource.sharedInstance(realm)
    return Repository.sharedInstance(remote, locale)
  }
  
  func provideHome() -> HomeUseCase {
    return HomeInteractor(repository: provideRepository())
  }
  
  func provideTab1() -> Tab1UseCase {
    return Tab1Interactor(repository: provideRepository())
  }
  
}