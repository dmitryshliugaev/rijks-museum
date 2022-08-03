//
//  ArtDetails.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

struct ArtDetails {
    let id: String
    let objectNumber: String
    let longTitle: String?
    let principalOrFirstMaker: String?
    let description: String?
    let webImage: ArtImage
    
    init(artDetailResponse: ArtDetailObjectResponse) {
        self.id = artDetailResponse.id
        self.objectNumber = artDetailResponse.objectNumber
        self.longTitle = artDetailResponse.longTitle
        self.principalOrFirstMaker = artDetailResponse.principalOrFirstMaker
        self.description = artDetailResponse.description
        self.webImage = ArtImage(imageResponse: artDetailResponse.webImage)
    }
}
