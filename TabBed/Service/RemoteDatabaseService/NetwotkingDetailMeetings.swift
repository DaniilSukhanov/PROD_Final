//
//  NetwotkingDetailMeetings.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import Foundation



// MARK: - DetailInfoMeeting
struct DetailInfoMeeting: Codable, Sendable {
    let date: String
    let place: Place
    let participants: [Participant]
    let id: Int
    let documents: Documents
    let agent: Agent
    let isCanceled: Bool
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case date, place, participants, id, documents, agent
        case isCanceled = "is_canceled"
        case type
    }
}

// MARK: - Documents
struct Documents: Codable, Sendable {
    let id: Int
    let documents: [String]
}


typealias DetailInfoMeetings = [DetailInfoMeeting]

