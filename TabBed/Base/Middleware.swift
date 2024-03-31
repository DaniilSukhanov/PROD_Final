//
//  Middleware.swift
//  LifestyleHUB
//
//  Created by Даниил Суханов on 16.03.2024.
//

import Foundation

typealias Middleware<AppAction: Sendable> = (AppAction) async -> AppAction?
