//
//  Dependency.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

class Dependency {
    static let sharedInstance = Dependency()
    
    private init() {}
    
    lazy var networkEnvironment: NetworkEnvironmentProtocol = {
        return RijksEnvironment()
    }()
    
    lazy var networkService: RijksNetworkServiceProtocol = {
        return RijksNetworkService(environment: networkEnvironment)
    }()
    
    lazy var repository: RijksRepositoryProtocol = {
        return RijksRepository(networkService: networkService)
    }()
    
    lazy var imageCache: ImageCacheProtocol = {
        return ImageCache()
    }()
    
    lazy var imageDownloader: ImageDownloaderProtocol = {
        return ImageDownloader(cache: imageCache)
    }()
}
