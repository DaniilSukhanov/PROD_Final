//
//  RootReducer.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation

@Sendable func rootReducer(_ state: inout RootState, _ action: RootAction) {
    switch action {
    case .detailMeeting(let action):
        detailMeetingReducer(&state.detailMeeting, action)
    case .mainAction(let action):
        mainReducer(&state.main, action)
    case .addingMeetingAction(let action):
        addingMeetingReducer(&state.addingMeeting, action)
    case .setCurrentView(let value):
        state.currentView = value
    default:
        break
    }
}
