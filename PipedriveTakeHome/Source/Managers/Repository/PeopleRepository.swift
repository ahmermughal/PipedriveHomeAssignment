//
//  PeopleRepository.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation
import Combine

/// The PeopleRepository class serves as a repository for managing and handling a list of people. It encapsulates the logic to interact with the network manager and persistence service to fetch and save data.
/// The class defines several published properties that represent the current state of the data, such as the list of people, the data source type, and flags indicating loading status.
class PeopleRepository {
    
    enum RepoDataType {
        case Network
        case Storage
    }
    
    // MARK: Variables and Publishers
    private var subscriptions: [AnyCancellable] = []
    
    /// Published properties to observe changes in the data
    @Published private(set) var peopleListData: ([Person], RepoDataType)?
    @Published private(set) var peopleList: [Person] = []
    @Published private(set) var showLoader: Bool?
    @Published private(set) var hasNext = false
    @Published private(set) var isLoadingNext = false
    
    let persistenceService: PersistenceServiceProtocol
    let networkManager: NetworkManagerProtocol

    private var currentPage: Int = 1

    // MARK: Init
    init(networkManager: NetworkManagerProtocol, persistenceService: PersistenceServiceProtocol) {
        self.networkManager = networkManager
        self.persistenceService = persistenceService
    }
    
    
    // MARK: Functions
    /// Used to reset the data in repository by setting peopleList to empty, hasNext to false and currentPage back to 1.
    func resetData() {
        /// Reset the data in the repository
        peopleList = []
        hasNext = false
        currentPage = 1
    }
    
    /// Used to retrieve a list of persons from `NetworkManager`. When successfully retrieve persons list then save list using `PersistenceService`.
    /// When there is no internet and `NetworkManager` returns `noInternet` error then retrieve the saved list from `PersistenceService`.
    /// PersonList can be retrieved by subscribing to `peopleListData` or `peopleList` publishers.
    func getAllPerson() {
        /// Set showLoader flag to indicate loading
        showLoader = true
        
        /// Call the network manager to get all persons with the current page
        networkManager.getAllPersons(page: currentPage)
            .sink(receiveCompletion: handleCompletion, receiveValue: handlePeopleResponse)
            .store(in: &subscriptions)
    }
    
    // MARK: Private functions
    private func handlePeopleResponse(response: PersonsResponse) {
        /// Handle the response received from the network manager
        
        /// Check if the response data is empty
        guard !response.data.isEmpty else {
            /// Set the peopleListData to an empty array with the .Network type
            peopleListData = ([], .Network)
            return
        }
                
        /// Append the response data to the existing peopleList
        peopleList.append(contentsOf: response.data)
        
        /// Set the peopleListData to the updated peopleList with the .Network type
        peopleListData = (peopleList, .Network)
        
        /// Save the updated peopleList to the persistence service
        persistenceService.savePeopleList(list: peopleList)
        
        /// Check if there are any more items in the pagination
        if let anyMoreItems = response.additionalData?.pagination.anyMoreItem, anyMoreItems {
            /// Increment the current page and set hasNext flag to true
            currentPage += 1
            hasNext = true
        } else {
            /// Set hasNext flag to false if there are no more items
            hasNext = false
        }
    }
    
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>) {
        /// Handle the completion of the network request
        
        /// Set showLoader and isLoadingNext flags to false
        showLoader = false
        isLoadingNext = false
        
        if case .failure(.noInternet) = completion {
            /// Reset the data if there is a failure due to no internet connection
            resetData()
            
            /// Retrieve the saved people list from the persistence service
            let savedList = persistenceService.getPeopleList()
            peopleList = savedList
            
            /// Set the peopleListData to the saved list with the .Storage type
            peopleListData = (peopleList, .Storage)
        }
    }

}
