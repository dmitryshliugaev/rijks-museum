//
//  RijksRepository.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

protocol RijksRepositoryProtocol {
    func getCollection(page: Int,
                       completion: @escaping (_ result: Result<ArtCollection, Error>) -> Void)
    func getCollectionDetail(objectNumber: String,
                             completion: @escaping (_ result: Result<ArtDetails, Error>) -> Void)
}

final class RijksRepository: RijksRepositoryProtocol {
    private let networkService: RijksNetworkServiceProtocol
    
    init(networkService: RijksNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getCollection(page: Int,
                       completion: @escaping (_ result: Result<ArtCollection, Error>) -> Void) {
        networkService.fetchArtList(page: page) { result in
            switch result {
            case .success(let response):
                let collection = ArtCollection(collectionResponse: response)
                completion(.success(collection))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCollectionDetail(objectNumber: String,
                             completion: @escaping (_ result: Result<ArtDetails, Error>) -> Void) {
        networkService.fetchArtDetail(objectNumber: objectNumber) { result in
            switch result {
            case .success(let response):
                let artDetails = ArtDetails(artDetailResponse: response.artObject)
                completion(.success(artDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
