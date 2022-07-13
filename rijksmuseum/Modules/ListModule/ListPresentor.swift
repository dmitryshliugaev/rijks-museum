//
//  ListPresentor.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol ListModulesOutput {
    func didSelectPicture()
}

class ListPresentor: ListViewOutput {
    weak var view: ListViewInput?
    
    func selectPicture() {
        
    }
}
