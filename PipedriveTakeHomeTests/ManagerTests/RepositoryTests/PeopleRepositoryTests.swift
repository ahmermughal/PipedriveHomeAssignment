//
//  PeopleRepositoryTests.swift
//  PipedriveTakeHomeTests
//
//  Created by Ahmer Akhter on 02/07/2023.
//

import XCTest
import Combine
@testable import PipedriveTakeHome

final class PeopleRepositoryTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    var repository: PeopleRepository!
    var mockPersistenceService: MockPersistenceService!
    var mockNetworkManager: MockNetworkManager!
    
    
    
    override func setUpWithError() throws {
        // GIVEN
        mockPersistenceService = MockPersistenceService()
        mockNetworkManager = MockNetworkManager()
        repository = PeopleRepository(networkManager: mockNetworkManager, persistenceService: mockPersistenceService)
        
    }
    
    override func tearDownWithError() throws {
        repository = nil
        mockPersistenceService = nil
        mockNetworkManager = nil
        
    }
    
    /// This is a test function for the `getAllPerson` function of the `PeopleRepository` class. It tests whether the function can successfully retrieve a list of `Person` when the NetworkManger is provided with valid data. Here's a breakdown of the different sections:
    /// - GIVEN: `PeopleRepository` with a mocked `NetworkManager` and an initial state.
    /// - WHEN: A sample object of `PersonsResponse` is setup with a list of 3 people and pagination data. This sample object is passed to the `MockNetworkManager`. The `getAllPerson` function of repository is called to fetch list of `Person`.
    /// - THEN: `peopleListData` publisher is observed for a valid list of `Persons`, repoType is .Network and `getAllPerson` is invoked once.
    func testGetAllPerson_WhenValidResponseReceived_ShouldUpdatePeopleList() {
       
        // WHEN
        /// Create a sample list of Person objects
        let peopleList = [
            Person(id: 1, name: "John", organizationName: "Org", phone: [], email: [], picture: nil),
            Person(id: 2, name: "Jane", organizationName: "Org", phone: [], email: [], picture: nil),
            Person(id: 3, name: "Mark", organizationName: "Org", phone: [], email: [], picture: nil)
        ]
        /// Create a sample object of `PaginationData`
        let paginationData = PaginationData(start: 0, limit: 5, anyMoreItem: false)
        
        /// Create a sample object of `AdditionalData`
        let additionalData = AdditionalData(pagination: paginationData)
        
        /// Create a sample object of `PersonsResponse` from the above objects
        let response = PersonsResponse(success: true, data: peopleList, additionalData: additionalData)
        
        /// Pass `PersonsResponse` object to the `MockNetworkManager` object
        mockNetworkManager.stubbedGetAllPersonsResult = Result.success(response)
        
        /// Retrieve the list of all person from the repository
        repository.getAllPerson()
        
        // THEN
        /// Create an expectation to wait for the asynchronous completion of the network request
        let expectation = self.expectation(description: "Network")
        
        /// Subscribe to the `peopleListData` publisher to verify the expected changes
        repository.$peopleListData
            .compactMap { $0 }
            .sink { data in
                /// Ensure that `getAllPersons` is called once
                XCTAssertEqual(self.mockNetworkManager.invokedGetAllPersonsCount, 1, "getAllPersons function should be called once")
                
                /// Ensure that the received list is not empty
                XCTAssertTrue(!data.0.isEmpty, "Retrieved List should not be empty")
                
                /// Ensure that the repoDataType is set to .Network
                XCTAssertEqual(data.1, .Network, "repoDataType should be .Network")
                
                /// Fulfill the expectation to indicate that the verification is complete
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        /// Wait for the expectation to be fulfilled, or until the timeout expires
        self.wait(for: [expectation], timeout: 5)
    }

    /// This is a test function for the `getAllPerson` function of the `PeopleRepository` class. It tests whether `hasNext` variable is true when the NetworkManger returns paginationData with anyMoreItem set to true . Here's a breakdown of the different sections:
    /// - GIVEN: `PeopleRepository` with a mocked `NetworkManager` and an initial state.
    /// - WHEN: A sample object of `PersonsResponse` is setup with a list of people and pagination data with anyMoreItem set to true . This sample object is passed to the `MockNetworkManager`. The `getAllPerson` function of repository is called to fetch list of `Person`.
    /// - THEN: `peopleListData` publisher is observed for to ensure `getAllPersons` is invoked once and `hasNext` is true.
    func testGetAllPerson_WhenPaginationAnyMoreItemIsTrue_ThenHasNextIsTrue() {
        
        // WHEN
        /// Create a sample list of Person objects
        let peopleList = [
            Person(id: 1, name: "John", organizationName: "Org", phone: [], email: [], picture: nil)
        ]
        
        /// Create a sample object of `PaginationData`
        let paginationData = PaginationData(start: 0, limit: 5, anyMoreItem: true)
        
        /// Create a sample object of `AdditionalData`
        let additionalData = AdditionalData(pagination: paginationData)
        
        /// Create a sample object of `PersonsResponse` from the above objects
        let response = PersonsResponse(success: true, data: peopleList, additionalData: additionalData)
        
        /// Pass `PersonsResponse` object to the `MockNetworkManager` object
        mockNetworkManager.stubbedGetAllPersonsResult = Result.success(response)
        
        /// Retrieve the list of all person from the repository
        repository.getAllPerson()
        
        // THEN
        /// Create an expectation to wait for the asynchronous completion of the network request
        let expectation = self.expectation(description: "Network")
        
        /// Subscribe to the `peopleList` publisher to verify the expected changes
        repository.$peopleList
            .sink { _ in
                /// Ensure that `getAllPersons` is called once
                XCTAssertEqual(self.mockNetworkManager.invokedGetAllPersonsCount, 1, "getAllPersons function should be called once")
                
                /// Ensure that `hasNext` is true
                XCTAssertTrue(self.repository.hasNext, "hasNext should be true")
                
                /// Fulfill the expectation to indicate that the verification is complete
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        /// Wait for the expectation to be fulfilled, or until the timeout expires
        self.wait(for: [expectation], timeout: 5)
    }
    
    /// This is a test function for the `getAllPerson` function of the `PeopleRepository` class. It tests whether the function can successfully retrieve an empty list of `Person` when the NetworkManger is provided an empty list. Here's a breakdown of the different sections:
    /// - GIVEN: `PeopleRepository` with a mocked `NetworkManager` and an initial state.
    /// - WHEN: A sample object of `PersonsResponse` is setup with an empty list of people. This sample object is passed to the `MockNetworkManager`. The `getAllPerson` function of repository is called to fetch list of `Person`.
    /// - THEN: `peopleListData` publisher is observed for to ensure `getAllPersons` is invoked once and result list is empty.
    func testGetAllPerson_WhenEmptyResponseReceived_ThenPeopleListDataHasEmptyList() {
        
        // WHEN
        /// Create a sample object of `PersonsResponse` with empty data list
        let response = PersonsResponse(success: true, data: [], additionalData: nil)
        
        /// Pass `PersonsResponse` object to the `MockNetworkManager` object
        mockNetworkManager.stubbedGetAllPersonsResult = Result.success(response)
        
        /// Retrieve the list of all person from the repository
        repository.getAllPerson()
        
        // THEN
        /// Create an expectation to wait for the asynchronous completion of the network request
        let expectation = self.expectation(description: "Network")
        
        /// Subscribe to the `$peopleListData` publisher to verify the expected changes
        repository.$peopleListData
            .compactMap{$0}
            .sink { data in
                
                /// Ensure that `getAllPersons` is called once
                XCTAssertEqual(self.mockNetworkManager.invokedGetAllPersonsCount, 1, "getAllPersons function should be called once")
                
                /// Ensure that the received list is empty
                XCTAssertTrue(data.0.isEmpty, "Retrieved list should be empty")
                
                /// Fulfill the expectation to indicate that the verification is complete
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        /// Wait for the expectation to be fulfilled, or until the timeout expires
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    /// This is a test function for the `getAllPerson` function of the `PeopleRepository` class. It tests whether the function can successfully retrieve a list of `Person` when the NetworkManger returns with an `noInternet` error and `MockPersistenceService` is provided with a valid data. Here's a breakdown of the different sections:
    /// - GIVEN: `PeopleRepository` with a mocked `NetworkManager` and a mocked `PersistenceService`.
    /// - WHEN: A sample object of `PersonsResponse` is setup with an list of people. This sample object is passed to the `MockPersistenceService` and `noInternet` error is passed to `MockNetworkManager`. The `getAllPerson` function of repository is called to fetch list of `Person`.
    /// - THEN: `peopleListData` publisher is observed for to ensure `getPeopleList`in `MockPersistenceService` is invoked once, a valid list of count 1 is returned and the repoType is .Storage
    func testGetAllPerson_WhenNoInternetErrorReceived_ShouldUpdatePeopleListDataFromPersistence() {
        
        // WHEN
        /// Create a sample list of Person objects
        let peopleList = [
            Person(id: 1, name: "John", organizationName: "Org", phone: [], email: [], picture: nil)
        ]
        
        /// Pass `noInternet` error to `MockNetworkManager` object
        mockNetworkManager.stubbedGetAllPersonsResult = Result.failure(NetworkError.noInternet)
        
        /// Pass `PersonsResponse` object to the `MockPersistenceService` object
        mockPersistenceService.stubbedGetPeopleListResult = peopleList
        
        /// Retrieve the list of all person from the repository
        repository.getAllPerson()
        
        // THEN
        /// Create an expectation to wait for the asynchronous completion of the network request
        let expectation = self.expectation(description: "Network")
        /// Subscribe to the `$peopleListData` publisher to verify the expected changes
        repository.$peopleListData
            .compactMap{$0}
            .sink { data in
                
                /// Ensure that `getPeopleList` is called once
                XCTAssertEqual(self.mockPersistenceService.invokedGetPeopleListCount, 1, "getPeopleList function should be called once")
                
                /// Ensure that the received list count is 1
                XCTAssertEqual(data.0.count, 1, "Retrieved list count should be 1")
                
                /// Ensure that the repoDataType is set to .Storage
                XCTAssertEqual(data.1, .Storage, "repoDataType should be .Storage")
                
                /// Fulfill the expectation to indicate that the verification is complete
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        /// Wait for the expectation to be fulfilled, or until the timeout expires
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    
    
}
