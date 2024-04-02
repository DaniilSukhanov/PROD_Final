//
//  DetailMeetingModel.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation
import SwiftUI

struct DetailMeetingModel {
    let agent: AgentModel
    let date: String
    let place: String
    let status: StatusMeeting
    let documents: [String]
    let id: Int
    let participants: [Participant]
}
