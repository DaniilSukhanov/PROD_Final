//
//  AddingMeetingAction.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

enum AddingMeetingAction: ActionProtocol {
    case setPlace(String?)
    case setName(String?)
    case setDate(Date?)
    case setTime(Date?)
}
