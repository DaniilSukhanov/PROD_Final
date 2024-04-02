//
//  RemoteDatabaseService.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

@preconcurrency import Foundation

protocol RemoteDatabaseServiceProtocol: NetworkingProtocol {
    func getMeetings() async throws -> [ShortInfoMeeting]
    func getDetailMeeting(id: Int) async throws -> DetailInfoMeeting
    func deleteMeeting(id: Int) async throws
    func createMeeting(_ meeting: ConfigurationMeeting) async throws
    func updateMeeting(_ meeting: ConfigurationMeeting, id: Int) async throws
    func getAgents(longitude: Double, latitude: Double, dateTime: Date) async throws -> [NetworkingAgent]
    func getProducts() async throws -> NetworkingProducts
    func clickBanner(id: Int) async throws
}

actor RemoteDatabaseService: RemoteDatabaseServiceProtocol {
    let baseURL: URL?
    
    private let encoder = {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        return encoder
    }()
    
    init(baseURL: URL?) {
        self.baseURL = baseURL
    }
    
    func getMeetings() async throws -> [ShortInfoMeeting] {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/meetings/"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        let (data, _) = try await URLSession(configuration: .default).data(for: request)
        let models = try JSONDecoder().decode([ShortInfoMeeting].self, from: data)
        return models
    }
    
    func getDetailMeeting(id: Int) async throws -> DetailInfoMeeting {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/meetings/\(id)"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        let (data, _) = try await URLSession(configuration: .default).data(for: request)
        let model = try JSONDecoder().decode(DetailInfoMeeting.self, from: data)
        return model
    }
    
    func deleteMeeting(id: Int) async throws {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/meetings/\(id)"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        request.httpMethod = "DELETE"
        let (_, responce) = try await URLSession(configuration: .default).data(for: request)
        if (responce as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkingError.failedData((responce as? HTTPURLResponse)?.statusCode ?? -1)
        }
    }
    
    func updateMeeting(_ meeting: ConfigurationMeeting, id: Int) async throws {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/meetings/\(id)/"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        request.setValue("application/json", forHTTPHeaderField: "content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "PATCH"
        request.httpBody = try JSONEncoder().encode(meeting)
        let (_, responce) = try await URLSession(configuration: .default).data(for: request)
        
        if (responce as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkingError.failedData((responce as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
    }
    
    func createMeeting(_ meeting: ConfigurationMeeting) async throws {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/meetings/"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpBody = try encoder.encode(meeting)
        request.httpMethod = "POST"
        let (_, responce) = try await URLSession(configuration: .default).data(for: request)
        if (responce as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkingError.failedData((responce as? HTTPURLResponse)?.statusCode ?? -1)
        }
    }
    
    func getAgents(longitude: Double, latitude: Double, dateTime: Date) async throws -> [NetworkingAgent] {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(
            url: try baseURL.addMethod(
                urlMethod: "/agents", parameters: [
                    "longitude": String(longitude),
                    "latitude": String(latitude),
                    "date_time": Formatters.dateFormaterForNetworking.string(from: dateTime)
                ]
            ).addMethod(urlMethod: "/")
        )
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        let (data, _) = try await URLSession(configuration: .default).data(for: request)
        return try JSONDecoder().decode([NetworkingAgent].self, from: data)
    }
    
    func getProducts() async throws -> NetworkingProducts {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/products/"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        let (data, _) = try await URLSession(configuration: .default).data(for: request)
        return try JSONDecoder().decode(NetworkingProducts.self, from: data)
    }
    
    func clickBanner(id: Int) async throws {
        guard let baseURL else {
            throw NetworkingError.badURL
        }
        var request = URLRequest(url: try baseURL.addMethod(urlMethod: "/products/\(id)"))
        request.setValue(StoreTokens.tokenRemoteDatabase.token, forHTTPHeaderField: StoreTokens.tokenRemoteDatabase.key)
        request.httpMethod = "POST"
        let (_, responce) = try await URLSession(configuration: .default).data(for: request)
        if (responce as? HTTPURLResponse)?.statusCode != 200 {
            throw NetworkingError.failedData((responce as? HTTPURLResponse)?.statusCode ?? -1)
        }
    }
}
