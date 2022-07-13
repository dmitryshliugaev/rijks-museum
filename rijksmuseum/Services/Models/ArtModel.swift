//
//  ArtModel.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct ArtModel: Decodable {
    let id: String
    let objectNumber: String
    let title: String
    let longTitle: String
    let principalOrFirstMaker: String
    let webImage: WebImage
}

