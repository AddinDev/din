//
//  HaditsResponse.swift
//  din
//
//  Created by Addin Satria on 09/10/21.
//

import Foundation

// MARK: - HaditsBook
struct HaditsBookResponse: Codable {
    let code: Int
    let message: String
    let data: [HaditsNameResponse]
    let error: Bool
}

typealias HaditsNameResponses = [HaditsNameResponse]

// MARK: - Datum
struct HaditsNameResponse: Codable {
    let name, id: String
    let available: Int
}

// MARK: - HaditsResponse
struct HaditsesResponse: Codable {
    let code: Int
    let message: String
    let data: HaditsContainer
    let error: Bool
}

// MARK: - DataClass
struct HaditsContainer: Codable {
    let name, id: String
    let available, requested: Int
    let hadiths: HaditsResponses
}

typealias HaditsResponses = [HaditsResponse]

// MARK: - Hadith
struct HaditsResponse: Codable {
    let number: Int
    let arab, id: String
}
