//
//  DetailMeetingAction.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

enum DetailMeetingAction: ActionProtocol {
    case get(Int), set(DetailMeetingModel?), delete(Int)
}
