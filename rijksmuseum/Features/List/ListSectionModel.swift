//
//  ListSectionModel.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

struct ListSectionModel {
    var header: String
    let items: [ArtCollectionObject]
    var count: Int { items.count }
    
    func item(atItemIndex index: Int) -> ArtCollectionObject {
        return items[index]
    }
}
