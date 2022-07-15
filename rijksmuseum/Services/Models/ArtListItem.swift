//
//  ArtListItem.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct ArtListItem: Decodable, Equatable {
    let id: String
    let objectNumber: String
    let title: String?
    let webImage: WebImage?
    
    static func == (lhs: ArtListItem, rhs: ArtListItem) -> Bool {
        return lhs.id == rhs.id
    }
}

