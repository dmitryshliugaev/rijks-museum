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
    private let concurrentQueue = DispatchQueue(label: "nl.rijksmuseum.concurrent-queue", attributes: .concurrent)
    private var cache: [String: UIImage] = [:]
    
    func setImage(_ image: UIImage?, key: String) {
        concurrentQueue.async(flags: .barrier) {
            self.cache[key] = image
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        var image: UIImage?
        
        concurrentQueue.sync {
            image = cache[key]
        }
        
        return image
    }
}
