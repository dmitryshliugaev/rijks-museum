//
//  Collection.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct Collection: Decodable {
    let artObjects: [ArtListItem]
}
