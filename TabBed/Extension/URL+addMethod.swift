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
            let stringParameters = "?" + parameters.map { (key: String, value: String) in
                "\(key)=\(value)"
            }.joined(separator: "&")
            guard let url = URL(string: resultUrl.absoluteString + stringParameters) else {
                throw URLError.fieldAddMethod
            }
            resultUrl = url
        }
        return resultUrl
    }
}
