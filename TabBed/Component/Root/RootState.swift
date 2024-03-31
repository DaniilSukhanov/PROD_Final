//
//  RootState.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation
import SwiftUI

struct RootState: StateProtocol {
    var main = MainState()
    var detailMeeting = DetailMeetingState()
    var addingMeeting = AddingMeetingState()
}
