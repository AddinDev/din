//
//  AdzanResponse.swift
//  din
//
//  Created by Addin Satria on 09/10/21.
//

import Foundation

// MARK: - AdzanResponse
struct PrayTimeResponse: Codable {
    let data: AdzanResponses
}

typealias AdzanResponses = [AdzanResponse]

// MARK: - Datum
struct AdzanResponse: Codable {
    let timings: Timings
}

// MARK: - Timings
struct Timings: Codable {
    let fajr, sunrise, dhuhr, asr: String
    let sunset, maghrib, isha, imsak: String
    let midnight: String

    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case sunrise = "Sunrise"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case sunset = "Sunset"
        case maghrib = "Maghrib"
        case isha = "Isha"
        case imsak = "Imsak"
        case midnight = "Midnight"
    }
}
