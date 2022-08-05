//
//  MockNetworkService.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import Foundation

@testable import rijksmuseum

final class MockNetworkService: RijksNetworkServiceProtocol {
    private let mockState: MockState
    
    var page = 1
    var pageSize = Constants.Services.pageSize
    
    init(mockState: MockState) {
        self.mockState = mockState
    }
    
    func fetchArtList(page: Int,
                      pageSize: Int,
                      completion: @escaping (Result<ArtCollectionResponse, Error>) -> Void) {
        switch mockState {
        case .error:
            completion(.failure(MockError.mock))
        case .succes:
            self.page = page
            self.pageSize = pageSize
            
            do {
                let response = try JSONFileDecoder().decode(ArtCollectionResponse.self, from: "CollectionData")
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchArtDetail(objectNumber: String,
                        completion: @escaping (Result<ArtDetailsResponse, Error>) -> Void) {
        switch mockState {
        case .error:
            completion(.failure(MockError.mock))
        case .succes:
            do {
                let response = try JSONFileDecoder().decode(ArtDetailsResponse.self, from: "DetailsData")
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
