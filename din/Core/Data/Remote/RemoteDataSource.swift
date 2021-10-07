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
              print("TASK: got some Surahs")
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
}
