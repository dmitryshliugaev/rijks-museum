//
//  ArtObjectResponse.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct ArtObjectResponse: Decodable {
    let id: String
    let objectNumber: String
    let title: String?
    let webImage: ArtWebImageResponse
}

