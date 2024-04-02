//
//  MainMiddleware.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import SwiftUI

func mainMiddleware() -> Middleware<MainAction> {
    let networkingService = RemoteDatabaseService(baseURL: NetworkingURL.remoteDatabaseService)
    return { action in
        switch action {
        case .getMeetings:
            do {
                let metaDataMeetings = try await networkingService.getMeetings()
                var models = [ShortlyInfoMeetingModel]()
                
                for meeting in metaDataMeetings {
                    guard let date = Formatters.dateFormaterForNetworking.date(from: meeting.date) else {
                        continue
                    }
                    
                    let model = ShortlyInfoMeetingModel(
                        date: Formatters.dateFormaterForApp.string(from: date),
                        place: meeting.place.name,
                        participants: meeting.participants,
                        agent: .init(name: meeting.agent.name, phone: meeting.agent.phoneNumber, descrition: meeting.agent.description, photo: try await meeting.agent.photo.getImage(), id: meeting.agent.id),
                        status: meeting.isCanceled ? .cancel : .active,
                        id: meeting.id
                    )
                    models.append(model)
                }
                return .setMeetings(models)
            } catch {
                print(String(describing: error))
                return .setError(error.localizedDescription)
            }
        default:
            break
        }
        return nil
    }
}
