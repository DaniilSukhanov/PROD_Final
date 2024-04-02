//
//  RemoteDatabaseModels.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import Foundation

// MARK: - ShortInfoMeeting
struct ShortInfoMeeting: Codable, Sendable {
    let date: String
    let place: Place
    let participants: [Participant]
    let id: Int
    let agent: Agent
    let isCanceled: Bool
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case date, place, participants, id, agent
        case isCanceled = "is_canceled"
        case type
    }
}

// MARK: - Agent
struct Agent: Codable, Sendable {
    let id: Int
    let name, description, phoneNumber: String
    let photo: URL
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case phoneNumber = "phone_number"
        case photo
    }
}

// MARK: - Participant
struct Participant: Codable, Sendable {
    let name, position, phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case name, position
        case phoneNumber = "phone_number"
    }
}

// MARK: - Place
struct Place: Codable, Sendable {
    let name: String
    let longitude, latitude: Double
}


