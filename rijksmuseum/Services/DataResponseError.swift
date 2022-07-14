//
//  DataResponseError.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "network.error".localizedString
        case .decoding:
            return "decoding.error".localizedString
        }
    }
}
