//
//  ImageCache.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 02/08/2022.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func setImage(_ image: UIImage?, key: String)
    func getImage(forKey key: String) -> UIImage?
}

final class ImageCache: ImageCacheProtocol {
    private let isolationQueue = DispatchQueue(label: "nl.rijksmuseum.concurrent-queue", attributes: .concurrent)
    private var cache: [String: UIImage] = [:]
    private let maxCount = 100
    
    func setImage(_ image: UIImage?, key: String) {
        isolationQueue.async(flags: .barrier) {
            if self.cache.count > self.maxCount,
               let firstKey = self.cache.first?.key {
                self.cache.removeValue(forKey: firstKey)
            }
            self.cache[key] = image
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        var image: UIImage?
        
        isolationQueue.sync {
            image = cache[key]
        }
        
        return image
    }
}
