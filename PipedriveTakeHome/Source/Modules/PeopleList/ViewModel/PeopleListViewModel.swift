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

class PeopleListViewModel{
    
    @Published private(set) var peopleList: [Person] = []
    @Published private(set) var showLoader : Bool?
    @Published private(set) var state : PeopleListState?
    @Published private(set) var internetOffline : Bool?

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
    
    private func handlePeopleListData(_ list: [Person], _ type: PeopleRepository.RepoDataType){
        
        if list.isEmpty && type == .Network{
            state = .empty
            return
        } else if list.isEmpty && type == .Storage {
            state = .noInternet
            return
        }else {
            state = .allGood
            peopleList = list
        }
        
    }
    
}
