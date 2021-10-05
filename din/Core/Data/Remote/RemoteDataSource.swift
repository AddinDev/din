//
//  RemoteDataSource.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol {
  
}

final class RemoteDataSource {
  
  init() { }
  
  static let sharedInstance: RemoteDataSource = RemoteDataSource()
  
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
}
