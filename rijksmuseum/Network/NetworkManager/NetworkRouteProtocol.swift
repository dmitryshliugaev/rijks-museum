//
//  NetworkRouteProtocol.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

protocol NetworkRouteProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var queryParameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

// MARK: - Helpers

extension NetworkRouteProtocol {
    func createURLRequest(using environment: NetworkEnvironmentProtocol?) throws -> URLRequest {
        let baseURL = environment?.baseURL.absoluteString ?? ""
        
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidRequest
        }
        
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            var parameters: [String: Any] = [:]
            
            queryParameters.forEach { tuple in
                parameters [tuple.key] = tuple.value
            }
            
            let queryItems = parameters.compactMap({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: "\(value)")
            })
            
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if let headers = environment?.defaultHeaders, !headers.isEmpty {
            for header in headers.enumerated() {
                request.setValue(header.element.value, forHTTPHeaderField: header.element.key)
            }
        }
        
        if let headers = headers, !headers.isEmpty {
            for header in headers.enumerated() {
                request.setValue(header.element.value, forHTTPHeaderField: header.element.key)
            }
        }
        
        return request
    }
}
