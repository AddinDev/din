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
  func fetchHaditsName() -> AnyPublisher<HaditsNameResponses, Error>
  func fetchHadits(_ name: String, _ first: Int, _ end: Int) -> AnyPublisher<HaditsResponses, Error>
  func fetchAyah(id: Int) -> AnyPublisher<[String: AyahResponses], Error>
  func fetchAudio() -> AnyPublisher<AudioResponses, Error>
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
              print("TASKERROR: news: \(error.localizedDescription)")
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
              print("TASKERROR: adzan: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchHaditsName() -> AnyPublisher<HaditsNameResponses, Error> {
    return Future<HaditsNameResponses, Error> { completion in
      guard let url = URL(string: Api.haditsBookApi) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: HaditsBookResponse.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value.data))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: hadits: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchHadits(_ name: String, _ first: Int, _ end: Int) -> AnyPublisher<HaditsResponses, Error> {
    return Future<HaditsResponses, Error> { completion in
      guard let url = URL(string: Api.haditsApi(name: name, first, end)) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: HaditsesResponse.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value.data.hadiths))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: hadits: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchAyah(id: Int) -> AnyPublisher<[String: AyahResponses], Error> {
    return Future<[String: AyahResponses], Error> { completion in
      guard let url = URL(string: Api.surahApi(id: id)) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: AyahDetailResponse.self) { response in
          switch response.result {
            case .success(let value):
              var ayahs: [String: AyahResponses] = [:]
              ayahs["ar"] = value.data[0].ayahs
              ayahs["id"] = value.data[1].ayahs
              completion(.success(ayahs))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: ayahs: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
  func fetchAudio() -> AnyPublisher<AudioResponses, Error> {
    return Future<AudioResponses, Error> { completion in
      guard let url = URL(string: Api.audioApi) else { return }
      AF.request(url)
        .validate()
        .responseDecodable(of: AudioResponseContainer.self) { response in
          switch response.result {
            case .success(let value):
              completion(.success(value.documents))
            case .failure(let error):
              completion(.failure(error))
              print("TASKERROR: audio: \(error.localizedDescription)")
          }
        }
    }
    .eraseToAnyPublisher()
  }
  
}
