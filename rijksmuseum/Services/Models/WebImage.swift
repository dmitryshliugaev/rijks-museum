//
//  WebImage.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct WebImage: Decodable {
    let url: String
    
    func getURLForSmallImageSize() -> String {
        var newUrl = url
        newUrl.removeLast()
        return newUrl + Constants.downloadImageSize
    }
}
