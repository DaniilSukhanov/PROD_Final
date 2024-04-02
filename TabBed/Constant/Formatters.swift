//
//  Formatters.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import SwiftUI

struct Formatters {
    static let networkingDateFormate = "yyyy-MM-dd'T'HH:mm:SS"
    static let appDateFormate = "d MMMM yyyy 'в' HH:mm"
    
    static let dateFormaterForNetworking = {
        let formatter = DateFormatter()
        formatter.dateFormat = networkingDateFormate
        formatter.locale = Locale.init(identifier: "ru_RU")
        return formatter
    }()
    
    static let dateFormaterForApp = {
        let formatter = DateFormatter()
        formatter.dateFormat = appDateFormate
        formatter.locale = Locale.init(identifier: "ru_RU")
        return formatter
    }()
}
