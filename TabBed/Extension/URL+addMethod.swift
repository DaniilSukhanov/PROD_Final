//
//  URL+addMethod.swift
//  LifestyleHUB
//
//  Created by Даниил Суханов on 18.03.2024.
//

import Foundation

enum URLError: Error {
    case fieldAddMethod
}

extension URL {
    func addMethod(urlMethod: String, parameters: [String: String]? = nil) throws -> URL {
        var resultUrl = self.appendingPathComponent(urlMethod)
        if let parameters {
            var components = URLComponents(url: resultUrl, resolvingAgainstBaseURL: true)
            components?.queryItems = parameters.compactMap {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            guard let url = components?.url else {
                throw URLError.fieldAddMethod
            }
            resultUrl = url
        }
        return resultUrl
    }
}
