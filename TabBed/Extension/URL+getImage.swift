//
//  URL+getImage.swift
//  TabBed
//
//  Created by Даниил Суханов on 01.04.2024.
//

import SwiftUI
import UIKit


actor CacheImage {
    private let cache = NSCache<NSURL, UIImage>()
    
    static let shared = CacheImage()
    
    func get(url: URL) async throws -> Image {
        if let image = cache.object(forKey: url as NSURL) {
            return Image(uiImage: image)
        }
        let image = try await url.getUIImage()
        cache.setObject(image, forKey: url as NSURL)
        return Image(uiImage: image)
    }
}



extension URL {
    func getImage() async throws -> Image {
        return try await CacheImage.shared.get(url: self)
    }
    
    fileprivate func getUIImage() async throws -> UIImage {
        let (data, _) = try await URLSession(configuration: .default).data(from: self)
        guard let uiimage = UIImage(data: data) else {
            throw NetworkingError.badURL
        }
        return uiimage
    }
}
