//
//  DetailMeetingState.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

struct DetailMeetingState: StateProtocol {
    var isLoading = false
    var model: DetailMeetingModel?
}
