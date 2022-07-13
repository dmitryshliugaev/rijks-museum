//
//  ArtNetworkService.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol ArtNetworkServicing {
    func fetchArts(page: Int, completion: @escaping (Result<[ArtModel], Error>) -> Void)
}

final class ArtNetworkService: ArtNetworkServicing {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchArts(page: Int, completion: @escaping (Result<[ArtModel], Error>) -> Void) {
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
}


