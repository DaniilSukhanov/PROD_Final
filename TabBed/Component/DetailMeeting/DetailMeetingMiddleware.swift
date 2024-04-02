//
//  DetailMeetingMiddleware.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import Foundation

func detailMeetingMiddleware() -> Middleware<DetailMeetingAction> {
    let networkingService = RemoteDatabaseService(baseURL: NetworkingURL.remoteDatabaseService)
    return { action in
        switch action {
        case .get(let id):
            do {
                let netModel = try await networkingService.getDetailMeeting(id: id)
                guard let date = Formatters.dateFormaterForNetworking.date(from: netModel.date) else {
                    return .set(nil)
                }
                let agent = AgentModel(
                    name: netModel.agent.name, 
                    phone: netModel.agent.phoneNumber,
                    descrition: netModel.agent.description,
                    photo: try await netModel.agent.photo.getImage(),
                    id: netModel.agent.id
                )
                let model = DetailMeetingModel(
                    agent: agent,
                    date: Formatters.dateFormaterForApp.string(from: date),
                    place: netModel.place.name,
                    status: netModel.isCanceled ? .cancel : .active,
                    documents: netModel.documents.documents,
                    id: netModel.id, participants: netModel.participants
                )
                return .set(model)
            } catch {
                print("detailMeetingMiddleware", String(describing: error))
                return .set(nil)
            }
        case .delete(let id):
            do {
                try await networkingService.deleteMeeting(id: id)
                return .set(nil)
            } catch {
                print(error)
                return .set(nil)
            }
        default:
            break
        }
        return nil
    }
}

