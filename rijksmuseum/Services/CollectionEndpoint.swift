//
//  CollectionEndpoint.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

enum CollectionEndpoint {
    private var baseURL: String { return Constants.Services.baseURL }
    
    case collection(key: String, page: Int, pageSize: Int)
    case detail(key: String, objectNumber: String)
    
    private var fullPath: String {
        var endpoint:String
        
        switch self {
        case .collection(_, _, _):
            endpoint = "/collection"
        case let .detail(_, objectNumber):
            endpoint = "/collection/\(objectNumber)"
        }
        
        return baseURL + endpoint
    }
    
    var url: URL {
        switch self {
        case .collection(let key, let page, let pageSize):
            guard var urlComponents = URLComponents(string: fullPath) else {
                preconditionFailure("The url used in \(CollectionEndpoint.self) is not valid")
            }
            
            urlComponents.queryItems = [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "p", value: "\(page)"),
                URLQueryItem(name: "ps", value: "\(pageSize)")
            ]
            
            guard let url = urlComponents.url else {
                preconditionFailure("The url used in \(CollectionEndpoint.self) is not valid")
            }
            
            return url
            
        case .detail(let key, _):
            guard var urlComponents = URLComponents(string: fullPath) else {
                preconditionFailure("The url used in \(CollectionEndpoint.self) is not valid")
            }
            
            urlComponents.queryItems = [
                URLQueryItem(name: "key", value: key)
            ]
            
            guard let url = urlComponents.url else {
                preconditionFailure("The url used in \(CollectionEndpoint.self) is not valid")
            }
            
            return url
        }
    }
}
