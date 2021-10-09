//
//  Repository.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import Combine

protocol RepositoryProtocol {
  func fetchListofQuranChapters() -> AnyPublisher<SurahModels, Error>
  func fetchNews() -> AnyPublisher<NewsModels, Error>
  func fetchAdzan(lat: Float, long: Float) -> AnyPublisher<AdzanModels, Error>
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
  
  func fetchListofQuranChapters() -> AnyPublisher<SurahModels, Error> {
    self.remote.fetchListofQuranChapters()
      .map { SurahMapper.responsesToModels($0) }
      .eraseToAnyPublisher()
  }
  
  func fetchNews() -> AnyPublisher<NewsModels, Error> {
    self.remote.fetchNews()
      .map { NewsMapper.responsesToModels($0) }
      .eraseToAnyPublisher()
  }
  
  func fetchAdzan(lat: Float, long: Float) -> AnyPublisher<AdzanModels, Error> {
    self.remote.fetchAdzan(lat: lat, long: long)
      .map { AdzanMapper.responsesToModels($0) }
      .eraseToAnyPublisher()
  }

}
