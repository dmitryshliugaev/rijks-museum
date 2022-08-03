//
//  ArtNetworkServiceMock.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 15/07/2022.
//

import XCTest
@testable import rijksmuseum

class ArtNetworkServiceMock: ArtNetworkServicing {
    var isFetchArtListCalled = false
    var isFetchArtDetailCalled = false
    
    var isSuccessMode = true
    
    func fetchArtList(page: Int, completion: @escaping (Result<[ArtObjectResponse], DataResponseError>) -> Void) {
        isFetchArtListCalled = true
        
        if isSuccessMode {
            completion(.success([ArtObjectResponse(id: "", objectNumber: "", title: nil, webImage: nil)]))
        } else {
            completion(.failure(DataResponseError.network))
        }
    }
    
    func fetchArtDetail(objectNumber: String, completion: @escaping (Result<ArtDetailsResponse, DataResponseError>) -> Void) {
        isFetchArtDetailCalled = true
        
        if isSuccessMode {
            let artObject = ArtObjectResponse(id: "",
                                      objectNumber: "",
                                      longTitle: nil,
                                      principalOrFirstMaker: nil,
                                      description: nil,
                                      webImage: nil)
            completion(.success(ArtDetailsResponse(artObject: artObject)))
        } else {
            completion(.failure(DataResponseError.network))
        }
    }
}
