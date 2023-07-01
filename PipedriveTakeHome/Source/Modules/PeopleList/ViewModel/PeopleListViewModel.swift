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

class PeopleListViewModel{
    
    @Published private(set) var peopleList: [Person] = []
    @Published private(set) var showLoader : Bool?
    @Published private(set) var listIsEmpty : Bool?
    
    @Published private(set) var hasNext = false
    
    @Published private(set) var isLoadingNext = false
    
    
    private var subscriptions: [AnyCancellable] = []
    
    private var repository = PeopleRepository(networkManager: NetworkManager.shared, persistenceService: PersistenceService.shared)
    
    init() {
        setupRepoBinding()
    }
    
    func resetData(){

        repository.resetData()
    }
    
    func getPeople(){
        repository.getAllPerson()
    }
    
    
    private func setupRepoBinding(){
        
        repository.$listIsEmpty
            .assign(to: &$listIsEmpty)
        
        repository.$peopleList
            .assign(to: &$peopleList)
        
        repository.$showLoader
            .assign(to: &$showLoader)
        
        repository.$hasNext
            .assign(to: &$hasNext)
        
        repository.$isLoadingNext
            .assign(to: &$isLoadingNext)
        
    }
    
}
