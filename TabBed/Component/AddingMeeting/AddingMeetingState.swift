//
//  AddingMeetingState.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

struct AddingMeetingState: StateProtocol {
    var place: String?
    var date: Date?
    var name: String?
    var time: Date?
    var rangeTime: ClosedRange<Date>
}
