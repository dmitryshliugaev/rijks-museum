//
//  ImageDownloader.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation
import UIKit

protocol ImageDownloaderProtocol {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImageDownloader: ImageDownloaderProtocol {
    private let cache: ImageCacheProtocol
    
    init(cache: ImageCacheProtocol) {
        self.cache = cache
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cache.getImage(forKey: url.path) {
            completion(.success(image))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.hasSuccessStatusCode,
                      let data = data  else {
                    completion(.failure(NetworkError.invalidRequest))
                    return
                }
                
                if let image = UIImage(data: data) {
                    self.cache.setImage(image, key: url.path)
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkError.imageDataError))
                }
            }
        }
        
        task.resume()
    }
}
