//
//  AddingMeetingAction.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

enum AddingMeetingAction: ActionProtocol {
    case setPlace(Place?)
    case setName(String?)
    case setDate(Date?)
    case setTime(Date?)
    case toMain(Bool)
    case toggleActive1(Bool), toggleActive2(Bool), toggleActive3(Bool), toggleActive4(Bool)
    case correctAddress(String)
    case setError(String?)
    case createMeeting([Participant], Place?, Date?, Date?, Int?)
    case addParticipant(Participant)
    case removeLastParticipant
    case setParticipants([Participant])
    case setCurrentViewe(AddingMeetingCurrentView)
    case getAgents(Date)
    case setAgents([AgentModel]?)
    case setCurrentAgent(AgentModel?)
    case loadData(DetailMeetingModel)
    case resetData
    case setProducts([ProductModel]?)
    case getProducts
    case setComplited(Bool)
}
