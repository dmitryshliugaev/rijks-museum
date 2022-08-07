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
    var repository: RijksRepositoryProtocol?
    var router: ListModulesOutput?
    
    // MARK: - Properties
    private var sections: [ListSectionModel] = []
    
    private var page: Int = 1
    private var loading: Bool = false
    
    //MARK: - ListViewOutput
    func didLoad() {
        fetchArts()
    }
    
    func selectPicture(indexPath: IndexPath) {
        let item = sections[indexPath.section].item(atItemIndex: indexPath.row)
        router?.didSelectPicture(objectNumber: item.objectNumber)
    }
    
    func loadNewPage(currentItem: IndexPath) {
        if let lastSection = sections.last,
           currentItem.section == sections.count - 1,
           currentItem.row == lastSection.count - 1,
           !loading {
            fetchArts()
        }
    }
    
    func isLoading() -> Bool {
        return loading
    }
    
    //MARK: - Services
    func fetchArts() {
        loading = true
        repository?.getCollection(page: page, completion: { [weak self] result in
            guard let self = self else { return }
            
            self.loading = false
            
            switch result {
            case let .success(artCollection):
                self.sections.append(ListSectionModel(
                    header: "header.title".localizedString + "\(self.sections.count + 1)",
                    items: artCollection.artObjects
                ))
                
                self.page += 1
                
                DispatchQueue.main.async {
                    self.view?.updatePicturesList()
                }
                
            case let .failure(error):
    
                DispatchQueue.main.async {
                    self.view?.showErrorAlert(message: error.localizedDescription, tryAgainHandler: { [weak self] in
                        guard let self = self else { return }
                        
                        if !self.loading {
                            self.fetchArts()
                        }
                    })
                }
            }
        })
    }
}

//MARK: - ListViewItemsSourcing

extension ListPresenter: ListViewItemsSourcing {
    func numberOfSections() -> Int {
        return sections.isEmpty ? 0 : sections.count
    }
    
    func sectionHeader(index: Int) -> String {
        return sections[index].header
    }
    
    func itemsInSection(index: Int) -> Int {
        return sections[index].count
    }
    
    func itemModelFor(indexPath: IndexPath) -> ArtCollectionObject {
        return sections[indexPath.section].item(atItemIndex: indexPath.row)
    }
}
