//
//  NewsResponse.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import Foundation

// MARK: - IslamicNewsResponse
struct IslamicNewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsResponse]
}

typealias NewsResponses = [NewsResponse]

// MARK: - Article
struct NewsResponse: Codable {
    let source: Source
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
