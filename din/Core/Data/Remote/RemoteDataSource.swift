//
//  RemoteDataSource.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol {
  func fetchListofQuranChapters() -> AnyPublisher<SurahResponses, Error>
  func fetchNews() -> AnyPublisher<NewsResponses, Error>
  func fetchAdzan(lat: Float, long: Float) -> AnyPublisher<AdzanResponses, Error>
}

final class RemoteDataSource {
  
  init() {}
  
  static let sharedInstance: RemoteDataSource = RemoteDataSource()
  
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func fetchListofQuranChapters() -> AnyPublisher<SurahResponses, Error> {
    return Future<SurahResponses, Error> { completion in
      guard let url = URL(string: Api.quranApi) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: QuranResponse.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value.chapters))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchNews() -> AnyPublisher<NewsResponses, Error> {
    return Future<NewsResponses, Error> { completion in
      guard let url = URL(string: Api.newsApi) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: IslamicNewsResponse.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value.articles))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchAdzan(lat: Float, long: Float) -> AnyPublisher<AdzanResponses, Error> {
    return Future<AdzanResponses, Error> { completion in
      guard let url = URL(string: Api.adzanApi(lat: lat, long: long)) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: PrayTimeResponse.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value.data))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
}
