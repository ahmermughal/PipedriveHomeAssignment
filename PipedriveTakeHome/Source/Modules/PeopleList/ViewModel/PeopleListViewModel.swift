//
//  PeopleListViewModel.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation
import Combine

enum Section{
    case main
}

enum PeopleListState{
    case empty
    case noInternet
    case allGood
}

/// Responsible for managing the data and state related to a list of people.
/// It interacts with the `PeopleRepository` to retrieve and handle the list of people from both the network and local storage.
/// The class provides properties that represent the state of the people list, such as showLoader to indicate whether a loading indicator should be displayed, state to represent the overall state of the list (empty, noInternet, or allGood), and peopleList to store the retrieved list of people.
/// Overall, the PeopleListViewModel facilitates the retrieval, management, and presentation of the people list data in an organized and observable manner.
class PeopleListViewModel{
    
    // MARK: Variables and Publishers
    
    /// Published properties to observe changes in the data
    @Published private(set) var peopleList: [Person] = []
    @Published private(set) var showLoader : Bool?
    @Published private(set) var state : PeopleListState?
    @Published private(set) var internetOffline : Bool?
    @Published private(set) var hasNext = false
    @Published private(set) var isLoadingNext = false
    
    
    private var subscriptions: [AnyCancellable] = []
    
    /// An instance of PeopleRepository that manages fetching data from the network and persistence service.
    private var repository = PeopleRepository(networkManager: NetworkManager.shared, persistenceService: PersistenceService.shared)
    
    
    // MARK: Init
    
    init() {
        /// Initializes the PeopleListViewModel and sets up bindings with the repository.
        setupRepoBinding()
    }
    
    // MARK: Functions
    
    /// Resets the data in the repository.
    func resetData(){

        repository.resetData()
    }
    
    
    /// Retrieves all people from the repository.
    func getPeople(){
        repository.getAllPerson()
    }
    
    
    // MARK: Private functions
    
    /// Sets up bindings between the repository and the view model.
    private func setupRepoBinding(){
        
        repository.$peopleList
            .assign(to: &$peopleList)
        
        repository.$showLoader
            .assign(to: &$showLoader)
        
        repository.$hasNext
            .assign(to: &$hasNext)
        
        repository.$isLoadingNext
            .assign(to: &$isLoadingNext)
        
        repository.$peopleListData
            .compactMap{$0}
            .sink(receiveValue: handlePeopleListData)
            .store(in: &subscriptions)
        
    }
    
    /// Handles the people list data received from the repository.
    private func handlePeopleListData(_ list: [Person], _ type: PeopleRepository.RepoDataType){
        
        
        if list.isEmpty && type == .Network{
            /// Sets the state of the people list to empty if the list is empty and the type is network.
            state = .empty
            return
        } else if list.isEmpty && type == .Storage {
            /// Sets the state of the people list to noInternet if the list is empty and the type is storage.
            state = .noInternet
            return
        }else {
            /// Sets the state of the people list to allGood if the list is not empty.
            state = .allGood
            /// Updates the peopleList property with the new list.
            peopleList = list
        }
        
    }
    
}
