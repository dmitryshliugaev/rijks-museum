//
//  DetailPagePresentor.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol DetailPageModulesOutput {
    func back()
}

protocol DetailPageModulesInput {
    func configure(objectNumber: String)
}

final class DetailPagePresentor: DetailPageViewOutput, DetailPageModulesInput {
    // MARK: - Dependencies
    weak var view: DetailPageViewInput?
    var artNetworkService: ArtNetworkServicing!
    var router: DetailPageModulesOutput!
    
    // MARK: - Properties
    var objectNumber: String = ""
    
    //MARK: - ListViewOutput
    func didLoad() {
        fetchArtDetail(objectNumber: objectNumber)
    }
    
    //MARK: - ListViewOutput
    func configure(objectNumber: String) {
        self.objectNumber = objectNumber
    }
    
    //MARK: - Services
    
    //TODO: Need create Repository for data layer
    
    func fetchArtDetail(objectNumber: String) {
        artNetworkService.fetchArtDetail(objectNumber: objectNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(artDetail):
                DispatchQueue.main.async {
                    self.view?.configure(model: artDetail)
                }
                
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.showErrorAlert(message: error.reason, tryAgainHandler: { [weak self] in
                        guard let self = self else { return }
                        
                        self.fetchArtDetail(objectNumber: objectNumber)
                    }, noHandler: { [weak self] in
                        self?.router.back()
                    })
                }
            }
        }
    }
}
