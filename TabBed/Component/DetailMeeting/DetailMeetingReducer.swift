//
//  DetailMeetingReducer.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

@Sendable func detailMeetingReducer(_ state: inout DetailMeetingState, _ action: DetailMeetingAction) {
    switch action {
    case .get:
        state.isLoading = true
        state.model = nil
    case .set(let model):
        state.isLoading = false
        state.model = model
    }
}

