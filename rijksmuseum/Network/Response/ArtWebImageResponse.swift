//
//  ArtWebImageResponse.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit

struct ArtWebImageResponse: Decodable {
    let url: String
    let width: Double
    let height: Double
}
