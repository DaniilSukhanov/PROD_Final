//
//  Store.swift
//  LifestyleHUB
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation
import SwiftUI

// Класс для хранение, чтения состояния, а также для безопасного изменение состояния на главном потоке
@MainActor
final class Store<AppState: StateProtocol, AppAction: ActionProtocol>: ObservableObject {
    @Published private(set) var state: AppState
    private let reducer: Reducer<AppState, AppAction>
    private let middlewares: [Middleware<AppAction>]
    
    init(state: AppState, reducer: @escaping Reducer<AppState, AppAction>, middlewares: [Middleware<AppAction>]) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    // Измененят состояние по переданому действию
    nonisolated func dispatch(_ action: AppAction) {
        Task { @MainActor in
            await executeAction(action)
        }
    }
    
    private func executeAction(_ action: AppAction) async {
        reducer(&state, action)
        for middleware in middlewares {
            Task { @MainActor in
                guard let newAction = await middleware(action) else {
                    return
                }
                self.reducer(&state, newAction)
                
            }
        }
    }
}
