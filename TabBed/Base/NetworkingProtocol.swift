//
//  NetworkingProtocol.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

enum NetworkingError: Error {
    case badURL
    case notInternet
    case failedData(Int)
}

protocol NetworkingProtocol {
    init(baseURL: URL?)
}

