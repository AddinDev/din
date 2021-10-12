//
//  QuranResponse.swift
//  din
//
//  Created by Addin Satria on 07/10/21.
//

import Foundation

// MARK: - QuranResponse
struct QuranResponse: Codable {
    let chapters: [SurahResponse]
}

typealias SurahResponses = [SurahResponse]

// MARK: - Chapter
struct SurahResponse: Codable {
    let id: Int
    let revelationPlace: RevelationPlace
    let revelationOrder: Int
    let bismillahPre: Bool
    let nameSimple, nameComplex, nameArabic: String
    let versesCount: Int
    let pages: [Int]
    let translatedName: TranslatedName

    enum CodingKeys: String, CodingKey {
        case id
        case revelationPlace = "revelation_place"
        case revelationOrder = "revelation_order"
        case bismillahPre = "bismillah_pre"
        case nameSimple = "name_simple"
        case nameComplex = "name_complex"
        case nameArabic = "name_arabic"
        case versesCount = "verses_count"
        case pages
        case translatedName = "translated_name"
    }
}

enum RevelationPlace: String, Codable {
    case madinah = "madinah"
    case makkah = "makkah"
}

// MARK: - TranslatedName
struct TranslatedName: Codable {
    let languageName: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case languageName = "language_name"
        case name
    }
}

// MARK: - AyahResponse
struct AyahDetailResponse: Codable {
    let code: Int
    let status: String
    let data: [AyahEdition]
}

// MARK: - Datum
struct AyahEdition: Codable {
    let number: Int
    let name, englishName, englishNameTranslation, revelationType: String
    let numberOfAyahs: Int
    let ayahs: AyahResponses
}

typealias AyahResponses = [AyahResponse]

// MARK: - Ayah
struct AyahResponse: Codable {
    let number: Int
    let text: String
    let numberInSurah, juz, manzil, page: Int
    let ruku, hizbQuarter: Int
    let sajda: Bool
}
