//
//  Constants.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import UIKit

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
    
    struct List {
        static let imageHeight: CGFloat = 200
        static let indicatorHeight: CGFloat = 40
        static let artCellHeight: CGFloat = 250
        static let headerHeight: CGFloat = 60
    }
    
    struct UI {
        /// 5
        static let smallPadding: CGFloat = 5
        /// 10
        static let mediumPadding: CGFloat = 10
        /// 20
        static let largePadding: CGFloat = 30
    }
    
    struct Font {
        /// 16
        static let small: CGFloat = 16
        /// 20
        static let medium: CGFloat = 18
        //// 22
        static let large: CGFloat = 22
    }
}
