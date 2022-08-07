//
//  RijksRepositoryTests.swift
//  rijksmuseumTests
//
//  Created by Dmitrii Shliugaev on 07/08/2022.
//

import XCTest

@testable import rijksmuseum

class RijksRepositoryTests: XCTestCase {
    var repository: RijksRepository!
    
    let count: Int = 4400
    let objectNumber = "SK-A-133"
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        repository = nil
    }
    
    func testGetCollection_Success() {
        // Given
        repository = RijksRepository(networkService: MockNetworkService(mockState: .succes))
        let expectation = expectation(description: "get collection did mapping response model")
        
        // When
        repository.getCollection(page: 1) { result in
            switch result {
            case .success(let artCollection):
                XCTAssertEqual(artCollection.count, self.count)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetCollection_Failure() {
        // Given
        repository = RijksRepository(networkService: MockNetworkService(mockState: .error))
        let expectation = expectation(description: "get collection did error")
        
        // When
        repository.getCollection(page: 1) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetCollectionDetail_Success() {
        // Given
        repository = RijksRepository(networkService: MockNetworkService(mockState: .succes))
        let expectation = expectation(description: "get collection detail did mapping response model")
        
        // When
        repository.getCollectionDetail(objectNumber: objectNumber) { result in
            switch result {
            case .success(let artDetails):
                XCTAssertEqual(artDetails.objectNumber, self.objectNumber)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetCollectionDetail_Failure() {
        // Given
        repository = RijksRepository(networkService: MockNetworkService(mockState: .error))
        let expectation = expectation(description: "get collection detail did error")
        
        // When
        repository.getCollectionDetail(objectNumber: objectNumber) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.5)
    }
}
