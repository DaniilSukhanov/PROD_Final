//
//  MainAction.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

enum MainAction: ActionProtocol {
    case getMeetings, setMeetings([ShortlyInfoMeetingModel])
}
