//
//  ArtObject.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 14/07/2022.
//

import Foundation

struct ArtObject: Decodable {
    let id: String
    let objectNumber: String
    let longTitle: String?
    let principalOrFirstMaker: String?
    let description: String?
    let webImage: WebImage?
}
