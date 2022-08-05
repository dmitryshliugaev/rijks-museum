//
//  RijksNetworkService.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol RijksNetworkServiceProtocol {
    func fetchArtList(page: Int,
                      pageSize: Int,
                      completion: @escaping (Result<ArtCollectionResponse, Error>) -> Void)
    func fetchArtDetail(objectNumber: String,
                        completion: @escaping (Result<ArtDetailsResponse, Error>) -> Void)
}

// MARK: - Request builder

final class RijksNetworkService {
    private let environment: NetworkEnvironmentProtocol
    private var dataTask: URLSessionDataTask?
    
    init(environment: NetworkEnvironmentProtocol) {
        self.environment = environment
    }
    
    private func requestDecodable<T: Decodable>(route: NetworkRouteProtocol,
                                                completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = try? route.createURLRequest(using: environment) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
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
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        dataTask?.resume()
    }
}

// MARK: - Rijks request

extension RijksNetworkService: RijksNetworkServiceProtocol {
    func fetchArtList(page: Int,
                      pageSize: Int,
                      completion: @escaping (Result<ArtCollectionResponse, Error>) -> Void) {
        let route = RijksRoute.collection(page: page, pageSize: pageSize)
        requestDecodable(route: route, completion: completion)
    }
    
    func fetchArtDetail(objectNumber: String,
                        completion: @escaping (Result<ArtDetailsResponse, Error>) -> Void) {
        let route = RijksRoute.detail(objectNumber: objectNumber)
        requestDecodable(route: route, completion: completion)
    }
}


