//
//  RootAction.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation

enum RootAction: ActionProtocol {
    case mainAction(MainAction)
    case detailMeeting(DetailMeetingAction)
    case addingMeetingAction(AddingMeetingAction)
    case setCurrentView(CurrentView)
    case clickBanner(Int)
}
