//
//  ShortlyInfoMeetingModel.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation
import SwiftUI

struct ShortlyInfoMeetingModel: Equatable {
    static func == (lhs: ShortlyInfoMeetingModel, rhs: ShortlyInfoMeetingModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let date: String
    let place: String
    let participants: [Participant]
    let agent: AgentModel
    let status: StatusMeeting
    let id: Int
    let `type`: String
}
