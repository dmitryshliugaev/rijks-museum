//
//  RijksEnvironment.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

struct RijksEnvironment: NetworkEnvironmentProtocol {
    var baseURL: URL {
        return URL(string: Constants.Services.baseURL)!
    }
    
    var defaultHeaders: [String: String]? {
        return nil
    }
}

enum RijksRoute: NetworkRouteProtocol {
    case collection(page: Int)
    case detail(objectNumber: String)
    
    var body: Data? {
        return nil
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        case .collection(let page):
            return [
                "key": Constants.Services.apiKey,
                "p": page,
                "type": Constants.Services.artType,
                "imgonly": true
            ]
        case .detail:
            return [
                "key": Constants.Services.apiKey,
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .collection:
            return "en/collection"
        case .detail(let objectNumber):
            return "en/collection/\(objectNumber)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .collection, .detail:
            return .GET
        }
    }
}
