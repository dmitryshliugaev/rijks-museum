//
//  NetworkError.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 02/08/2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidRequest
    case noDataAvailable
    case mappingError(Error)
    case unknownError(Error)
    case imageDataError
}
