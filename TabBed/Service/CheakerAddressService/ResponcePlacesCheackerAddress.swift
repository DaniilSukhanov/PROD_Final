//
//  ResponcePlacesCheackerAddress.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

import Foundation

// MARK: - ResponcePlacesCheackerAddressElement
struct ResponcePlacesCheackerAddressElement: Codable, Sendable {
    let placeID: Int
    let licence, osmType: String
    let osmID: Int
    let lat, lon, responcePlacesCheackerAddressClass, type: String
    let placeRank: Int
    let importance: Double
    let addresstype, name, displayName: String
    let boundingbox: [String]

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case lat, lon
        case responcePlacesCheackerAddressClass = "class"
        case type
        case placeRank = "place_rank"
        case importance, addresstype, name
        case displayName = "display_name"
        case boundingbox
    }
}

typealias ResponcePlacesCheackerAddress = [ResponcePlacesCheackerAddressElement]

