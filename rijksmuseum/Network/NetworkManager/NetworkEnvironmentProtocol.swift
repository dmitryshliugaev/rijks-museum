//
//  NetworkEnvironmentProtocol.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 03/08/2022.
//

import Foundation

protocol NetworkEnvironmentProtocol {
    var baseURL: URL { get }
    var defaultHeaders: [String: String]? { get }
}
