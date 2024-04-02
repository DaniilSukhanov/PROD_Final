//
//  StoreTokens.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import Foundation


struct Token {
    let key: String
    let token: String
}


struct StoreTokens {
    static let tokenRemoteDatabase = Token(key: "Authorization", token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyfQ.N7Df4KQjubvTJmDxi19RkVuF-i9F4alpf5phPGsMKhs")
}
