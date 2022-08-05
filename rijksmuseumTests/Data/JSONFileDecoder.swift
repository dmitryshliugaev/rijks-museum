//
//  JSONFileDecoder.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import Foundation

@testable import rijksmuseum

enum JSONFileDecoderError: Error {
    case fileNotFound
    case fileNoString
    case invalidData
}

final class JSONFileDecoder {
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func decode<T>(_ decodableType: T.Type, from resource: String) throws -> T where T: Decodable {
        guard let path = Bundle(for: type(of: self)).path(forResource: resource, ofType: "json") else {
            throw JSONFileDecoderError.fileNotFound
        }
        
        guard let string = try? String(contentsOfFile: path, encoding: .utf8) else {
            throw JSONFileDecoderError.fileNoString
        }
        
        guard let data = string.data(using: .utf8) else {
            throw JSONFileDecoderError.invalidData
        }
        
        return try decoder.decode(decodableType, from: data)
    }
}
