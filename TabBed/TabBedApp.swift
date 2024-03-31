//
//  TabBedApp.swift
//  TabBed
//
//  Created by Даниил Суханов on 30.03.2024.
//

import SwiftUI

@main
@MainActor
struct TabBedApp: App {
    @StateObject var store = Store(state: RootState(), reducer: rootReducer, middlewares: [])
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}
