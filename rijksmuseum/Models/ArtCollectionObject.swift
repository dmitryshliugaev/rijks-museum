//
//  ArtCollectionObject.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

struct ArtCollectionObject: Equatable {
    let id: String
    let objectNumber: String
    let title: String?
    let webImage: ArtImage
    
    static func == (lhs: ArtCollectionObject, rhs: ArtCollectionObject) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(artObjectResponse: ArtObjectResponse) {
        self.id = artObjectResponse.id
        self.objectNumber = artObjectResponse.objectNumber
        self.title = artObjectResponse.title
        self.webImage = ArtImage(imageResponse: artObjectResponse.webImage)
    }
}
