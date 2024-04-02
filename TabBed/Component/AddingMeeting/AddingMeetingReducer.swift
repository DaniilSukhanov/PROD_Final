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
        state.currentView = .time
    case .setName(let name):
        state.name = name
    case .setPlace(let place):
        state.place = place
        state.isCheakingAddress = false
        if place != nil {
            state.currentView = .agent
        }
    case .setTime(let date):
        state.time = date
        state.currentView = .place
    case .toMain(let value):
        state.toMain = value
    case .toggleActive1(let value):
        state.isActive1 = value
    case .toggleActive2(let value):
        state.isActive2 = value
    case .toggleActive3(let value):
        state.isActive3 = value
    case .toggleActive4(let value):
        state.isActive4 = value
    case .correctAddress(_):
        state.isCheakingAddress = true
    case .setError(let error):
        state.error = error
        state.isCheakingAddress = false
    case .createMeeting:
        break
    case .addParticipant(let participant):
        state.participants.append(participant)
    case .removeLastParticipant:
        if !state.participants.isEmpty {
            state.participants.removeLast()
        }
    case .setParticipants(let value):
        state.participants = value
        state.currentView = .date
    case .setCurrentViewe(let value):
        state.currentView = value
    case .setCurrentAgent(let value):
        state.selectedAgent = value
        state.currentView = .complited
    case .getAgents:
        state.isLoadingAgents = true
        state.agents = nil
    case .setAgents(let value):
        state.agents = value
        state.isLoadingAgents = false
        state.isEdit = false
    case .loadData(let model):
        state.isEdit = true
        state.name = model.place
        state.selectedAgent = model.agent
        state.participants = model.participants
        state.place = .init(name: model.place, longitude: 0, latitude: 0)
        guard let date = Formatters.dateFormaterForApp.date(from: model.date) else {
            return
        }
        state.time = date
        state.date = date
        state.currentView = .participants
    case .resetData:
        state.time = nil
        state.date = nil
        state.name = nil
        state.place = nil
        state.selectedAgent = nil
        state.participants.removeAll()
    case .setProducts(let value):
        state.products = value
        state.isLoadingProducts = false
    case .getProducts:
        state.products = nil
        state.isLoadingProducts = true
    case .setComplited(let value):
        state.isComplited = value
        state.currentView = .complited
    }
    

}

