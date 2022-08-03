//
//  DetailPagePresenter.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol DetailPageModulesOutput {
    func didBack()
}

protocol DetailPageModulesInput {
    func configure(objectNumber: String)
}

final class DetailPagePresenter: DetailPageViewOutput, DetailPageModulesInput {
    // MARK: - Dependencies
    weak var view: DetailPageViewInput?
    var repository: RijksRepositoryProtocol?
    var router: DetailPageModulesOutput?
    
    // MARK: - Properties
    private var objectNumber: String = ""
    
    //MARK: - ListViewOutput
    func didLoad() {
        fetchArtDetail(objectNumber: objectNumber)
    }
    
    //MARK: - ListViewOutput
    func configure(objectNumber: String) {
        self.objectNumber = objectNumber
    }
    
    //MARK: - Services
    
    func fetchArtDetail(objectNumber: String) {
        repository?.getCollectionDetail(objectNumber: objectNumber, completion: { [weak self] result in
            switch result {
            case let .success(artDetail):
                DispatchQueue.main.async {
                    self?.view?.configure(model: artDetail)
                }
                
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.view?.showErrorAlert(message: error.localizedDescription, tryAgainHandler: {
                        self?.fetchArtDetail(objectNumber: objectNumber)
                    }, noHandler: {
                        self?.router?.didBack()
                    })
                }
            }
        })
    }
}
