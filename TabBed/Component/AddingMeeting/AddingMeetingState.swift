//
//  AddingMeetingState.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

enum AddingMeetingCurrentView {
    case participants, place, time, date, agent, complited
}

struct AddingMeetingState: StateProtocol {
    var participants = [Participant]()
    var place: Place?
    var date: Date?
    var name: String?
    var time: Date?
    var rangeTime: ClosedRange<Date>? = nil
    var isActive1 = false
    var isActive2 = false
    var isActive3 = false
    var isActive4 = false
    var isCheakingAddress = false
    var error: String?
    var currentView: AddingMeetingCurrentView = .participants
    var agents: [AgentModel]?
    var selectedAgent: AgentModel?
    var isLoadingAgents = false
    var toMain = false
    var isEdit = false
    var products: [ProductModel]?
    var isLoadingProducts = false
    var isComplited = false
}
