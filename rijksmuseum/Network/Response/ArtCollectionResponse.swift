//
//  ArtCollectionResponse.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct ArtCollectionResponse: Decodable {
    let count: Int
    let artObjects: [ArtObjectResponse]
}
