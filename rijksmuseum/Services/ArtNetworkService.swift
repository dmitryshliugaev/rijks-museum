//
//  ArtNetworkService.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol ArtNetworkServicing {
    func fetchArtList(page: Int, completion: @escaping (Result<[ArtListItem], DataResponseError>) -> Void)
    func fetchArtDetail(objectNumber: String, completion: @escaping (Result<ArtDetails, DataResponseError>) -> Void)
}

final class ArtNetworkService: ArtNetworkServicing {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchArtList(page: Int, completion: @escaping (Result<[ArtListItem], DataResponseError>) -> Void) {
        let endPoint = CollectionEndpoint.collection(key: Constants.Services.apiKey,
                                                     page: page,
                                                     pageSize: Constants.Services.pageSize)
        
        session.dataTask(with: endPoint.url, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.hasSuccessStatusCode,
                  let data = data  else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Collection.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse.artObjects))
        }).resume()
    }
    
    func fetchArtDetail(objectNumber: String, completion: @escaping (Result<ArtDetails, DataResponseError>) -> Void) {
        let endPoint = CollectionEndpoint.detail(key: Constants.Services.apiKey, objectNumber: objectNumber)
        
        session.dataTask(with: endPoint.url, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.hasSuccessStatusCode,
                  let data = data  else {
                completion(Result.failure(DataResponseError.network))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(ArtDetails.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse))
        }).resume()
    }
}


