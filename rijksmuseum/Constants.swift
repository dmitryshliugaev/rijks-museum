//
//  Constants.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

struct Constants {
    struct Image {
        static let downloadImageSize = "400"
    }
    
    struct Services {
        static let pageSize = 30
        
        #warning("This is not safe place for API KEY")
        static let apiKey = "0fiuZFh4"
        
        static let baseURL = "https://www.rijksmuseum.nl/api/nl"
    }
}
