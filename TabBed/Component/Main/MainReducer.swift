//
//  MainReducer.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

@Sendable func mainReducer(_ state: inout MainState, _ action: MainAction) {
    switch action {
    case .getMeetings:
        state.isLoadingMeetings = true
        state.shortlyInfoMeetingModels = []
    case .setMeetings(let models):
        state.isLoadingMeetings = false
        state.shortlyInfoMeetingModels = models
    }
}
