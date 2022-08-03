//
//  ArtImage.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

struct ArtImage {
    let url: String
    let width: Double
    let height: Double
    
    init(imageResponse: ArtWebImageResponse) {
        self.url = imageResponse.url
        self.width = imageResponse.width
        self.height = imageResponse.height
    }
    
    func getURLForSmallImageSize() -> String {
        var newUrl = url
        newUrl.removeLast()
        return newUrl + Constants.Image.downloadImageSize
    }
}
