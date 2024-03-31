//
//  REducer.swift
//  LifestyleHUB
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation

typealias Reducer<AppState: Sendable, AppAction: Sendable> = @Sendable (inout AppState, AppAction) -> ()
