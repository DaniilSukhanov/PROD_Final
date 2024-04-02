//
//  NetworkingConfigurationMeeting.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import Foundation

// MARK: - ConfigurationMeeting
struct ConfigurationMeeting: Codable, Sendable {
    let date: String
    let place: Place
    let participants: [Participant]
    let agentID: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case place
        case participants
        case agentID = "agent_id"
    }
}

// MARK: - NetworkingAgent
struct NetworkingAgent: Codable, Sendable {
    let id: Int
    let name, description, phoneNumber: String
    let photo: URL

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case phoneNumber = "phone_number"
        case photo
    }
}

// MARK: - NetworkingProduct
struct NetworkingProduct: Codable, Sendable {
    let id: Int
    let name, description: String
    let url: URL
    let image: URL
}

typealias NetworkingProducts = [NetworkingProduct]
