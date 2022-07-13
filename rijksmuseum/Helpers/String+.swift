//
//  String+.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

extension String {
  var localizedString: String {
    return NSLocalizedString(self, comment: "")
  }
}
