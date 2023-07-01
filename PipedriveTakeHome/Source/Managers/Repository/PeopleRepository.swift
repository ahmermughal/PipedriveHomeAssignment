//
//  PeopleRepository.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation
import Combine

class PeopleRepository {
    
    enum RepoDataType{
        case Network
        case Storage
    }
    
    private var subscriptions: [AnyCancellable] = []
    
    @Published private(set) var peopleListData: ([Person], RepoDataType)?

    
    @Published private(set) var peopleList: [Person] = []
    @Published private(set) var showLoader : Bool?
    
    @Published private(set) var hasNext = false
    
    @Published private(set) var isLoadingNext = false
    
    let persistenceService : PersistenceServiceProtocol
    let networkManager : NetworkManagerProtocol

    private var currentPage: Int = 1

    
    init(networkManager: NetworkManagerProtocol, persistenceService: PersistenceServiceProtocol) {
        self.networkManager = networkManager
        self.persistenceService = persistenceService
    }
    
    
    func getAllPerson(page: Int = 1){
        showLoader = true
        networkManager.getAllPersons(page: currentPage)
            .sink(receiveCompletion: handleCompletion, receiveValue: handlePeopleResponse)
            .store(in: &subscriptions)
    }
    
    
    private func handlePeopleResponse(response: PersonsResponse){
        
        guard !response.data.isEmpty else {
            peopleListData = ([], .Network)
            return
        }
                
        peopleList.append(contentsOf: response.data)
        
        peopleListData = (peopleList, .Network)
        
        PersistenceService.shared.savePeopleList(list: peopleList)
        
        if let anyMoreItems = response.additionalData?.pagination.anyMoreItem, anyMoreItems {
            currentPage += 1
            hasNext = true
        } else {
            hasNext = false
        }
        
    }
    
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>){
        showLoader = false
        isLoadingNext = false
        
        if case .failure(.noInternet) = completion{
            resetData()
            let savedList = persistenceService.getPeopleList()
            peopleList = savedList
            
            peopleListData = (peopleList, .Storage)

        }
    }
    
    func resetData(){
        peopleList = []
        hasNext = false
        currentPage = 1
    }
    
}
