//
//  MockRijksRepository.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import Foundation

@testable import rijksmuseum

final class MockRijksRepository: RijksRepositoryProtocol {
    
    private let mockState: MockState
    
    var page = 1
    
    init(mockState: MockState) {
        self.mockState = mockState
    }
    
    func getCollection(page: Int,
                       completion: @escaping (Result<ArtCollection, Error>) -> Void) {
        switch mockState {
        case .error:
            completion(.failure(MockError.mock))
        case .succes:
            self.page = page
            
            do {
                let response = try JSONFileDecoder().decode(ArtCollectionResponse.self, from: "CollectionData")
                let collection = ArtCollection(collectionResponse: response)
                completion(.success(collection))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getCollectionDetail(objectNumber: String,
                             completion: @escaping (Result<ArtDetails, Error>) -> Void) {
        switch mockState {
        case .error:
            completion(.failure(MockError.mock))
        case .succes:
            do {
                let response = try JSONFileDecoder().decode(ArtDetailsResponse.self, from: "DetailsData")
                let artDetails = ArtDetails(artDetailResponse: response.artObject)
                completion(.success(artDetails))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
