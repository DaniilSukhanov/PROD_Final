//
//  Middleware.swift
//  LifestyleHUB
//
//  Created by Даниил Суханов on 30.03.2024.
//

import Foundation

typealias Middleware<AppAction: Sendable> = (AppAction) async -> AppAction?
