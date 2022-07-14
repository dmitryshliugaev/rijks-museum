//
//  WebImage.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit

struct WebImage: Decodable {
    let url: String
    let width: Double
    let height: Double
    
    func getURLForSmallImageSize() -> String {
        var newUrl = url
        newUrl.removeLast()
        return newUrl + Constants.Image.downloadImageSize
    }
}
