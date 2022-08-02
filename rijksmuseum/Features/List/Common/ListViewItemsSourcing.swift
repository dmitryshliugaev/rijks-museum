//
//  ListViewItemsSourcing.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 14/07/2022.
//

import Foundation

protocol ListViewItemsSourcing {
    func numberOfSections() -> Int
    func itemsInSection(index: Int) -> Int?
    func itemModelFor(indexPath: IndexPath) -> ArtListItem?
}
