//
//  EventsResponse.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
// swiftlint:disable identifier_name

import Foundation

struct EventsResponse: Codable {
    let events: [Event]?
}

struct Event: Codable, Identifiable {
    let id: Int?
    let type: String?
    let datetime_utc: String?
    let venue: Venue?
    let performers: [Performers]?
    let stats: Stats?

    struct Venue: Codable {
        let name: String?
        let address: String?
        let country: String?
        let access_method: AccessMethod?
    }

    struct Performers: Codable, Identifiable {
        let id: Int?
        let name: String?
        let type: String?
        let image: String?
        let url: String?
    }

    struct Stats: Codable {
        let lowest_price: Double?
        let highest_price: Double?
    }
}

struct AccessMethod: Codable {
    let method: String?

    func accessWithQRCode() -> Bool {
        return method == "QRCODE"
    }
}
