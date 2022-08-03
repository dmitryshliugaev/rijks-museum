//
//  ArtCollection.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

struct ArtCollection {
    let count: Int
    let artObjects: [ArtCollectionObject]
    
    init(collectionResponse: ArtCollectionResponse) {
        self.count = collectionResponse.count
        self.artObjects = collectionResponse.artObjects.map({ ArtCollectionObject(artObjectResponse: $0 )})
    }
}
