//
//  MockState.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 05/08/2022.
//

import Foundation

@testable import rijksmuseum

enum MockState {
    case error
    case succes
}

enum MockError: Error {
    case mock
}
