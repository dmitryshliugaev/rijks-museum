//
//  ListPresenter.swift
//  rijksmuseum
//
//  Created by Dmitrii Shliugaev on 13/07/2022.
//

import Foundation

protocol ListModulesInput {
}

protocol ListModulesOutput {
    func didSelectPicture(objectNumber: String)
}

final class ListPresenter: ListViewOutput, ListModulesInput {
    
    // MARK: - Dependencies
    weak var view: ListViewInput?
    var artNetworkService: ArtNetworkServicing!
    var router: ListModulesOutput!
    
    // MARK: - Properties
    var arts: [Int: [ArtListItem]] = [:]
    var page: Int = 0
    var loading: Bool = false
    
    //MARK: - ListViewOutput
    func didLoad() {
        fetchArts(page: 0)
    }
    
    func selectPicture(indexPath: IndexPath) {
        if let artListItem = arts[indexPath.section]?[indexPath.row] {
            router.didSelectPicture(objectNumber: artListItem.objectNumber)
        }
    }
    
    func loadNewPage(currentItem: IndexPath) {
        if currentItem.row == arts.count - 1 && !loading {
            page += 1
            fetchArts(page: page)
        }
    }
    
    func isLoading() -> Bool {
        return loading
    }
    
    //MARK: - Services
    
    //TODO: Need create Repository for data layer
    
    func fetchArts(page: Int) {
        loading = true
        artNetworkService.fetchArtList(page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.loading = false
            
            switch result {
            case let .success(newArts):
                self.arts[self.page] = newArts
                
                DispatchQueue.main.async {
                    self.view?.updatePicturesList()
                }
                
            case let .failure(error):
                
                let prevPage = self.page
                
                if self.page > 0 {
                    self.page -= 1
                }
                
                DispatchQueue.main.async {
                    self.view?.showErrorAlert(message: error.reason, tryAgainHandler: { [weak self] in
                        guard let self = self else { return }
                        
                        if !self.loading {
                            self.fetchArts(page: prevPage)
                        }
                    })
                }
            }
        }
    }
}

//MARK: - ListViewItemsSourcing

extension ListPresenter: ListViewItemsSourcing {
    func numberOfSections() -> Int {
        return arts.isEmpty ? 0 : arts.count
    }
    
    func itemsInSection(index: Int) -> Int? {
        return arts[index]?.count
    }
    
    func itemModelFor(indexPath: IndexPath) -> ArtListItem? {
        return arts[indexPath.section]?[indexPath.row]
    }
    
}
