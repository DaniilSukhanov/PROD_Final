//
//  MainState.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

struct MainState: StateProtocol {
    var shortlyInfoMeetingModels = [ShortlyInfoMeetingModel]()
    var isLoadingMeetings = false
}
