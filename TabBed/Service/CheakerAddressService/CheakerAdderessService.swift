//
//  CheakerAdderessService.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

@preconcurrency import Foundation

protocol CheakerAdderessServiceProtocol: NetworkingProtocol  {
    func checkCorrectAddress(_ address: String) async throws
}

actor CheakerAdderessService: CheakerAdderessServiceProtocol {
    let baseURL: URL?
    init(baseURL: URL?) {
        self.baseURL = baseURL
    }
    
    func checkCorrectAddress(_ address: String) async throws {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        let parameters: [String: String] = [
            "limit": "1",
            "format": "json",
            "q": address
        ]
        let request = try URLRequest(url: baseURL.addMethod(urlMethod: "search", parameters: parameters))
        let (data, response) = try await URLSession(configuration: .default).data(for: request)
        if (response as? HTTPURLResponse)?.statusCode == 500 {
            throw NetworkingError.notInternet
        }
        if data.isEmpty {
            throw NetworkingError.failedData
        }
        
    }
}
