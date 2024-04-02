//
//  RootMiddleware.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

func rootMiddleware() -> Middleware<RootAction> {
    let addingMeetingMiddleware = addingMeetingMiddleware()
    let mainMiddleware = mainMiddleware()
    let detailMeetingMiddleware = detailMeetingMiddleware()
    let networkingService = RemoteDatabaseService(baseURL: NetworkingURL.remoteDatabaseService)
    return { action in
        switch action {
        case .addingMeetingAction(let action):
            guard let action = await addingMeetingMiddleware(action) else {
                return nil
            }
            return .addingMeetingAction(action)
        case .mainAction(let action):
            guard let action = await mainMiddleware(action) else {
                return nil
            }
            return .mainAction(action)
        case .detailMeeting(let action):
            guard let action = await detailMeetingMiddleware(action) else {
                return nil
            }
            return .detailMeeting(action)
        case .clickBanner(let id):
            do {
                try await networkingService.clickBanner(id: id)
            } catch {
                print(error)
            }
        default:
            break
        }
        return nil
    }
}
