//
//  AddingMeetingReducer.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

@Sendable func addingMeetingReducer(_ state: inout AddingMeetingState, _ action: AddingMeetingAction) {
    switch action {
    case .setDate(let date):
        state.date = date
    case .setName(let name):
        state.name = name
    case .setPlace(let place):
        state.place = place
    case .setTime(let date):
        state.date = date
    }
}

