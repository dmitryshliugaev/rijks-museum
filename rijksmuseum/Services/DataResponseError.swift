//
//  DataResponseError.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

enum DataResponseError: Error {
  case network
  case decoding
  
  var reason: String {
    switch self {
    case .network:
      return "An error occurred while fetching data".localizedString
    case .decoding:
      return "An error occurred while decoding data".localizedString
    }
  }
}
