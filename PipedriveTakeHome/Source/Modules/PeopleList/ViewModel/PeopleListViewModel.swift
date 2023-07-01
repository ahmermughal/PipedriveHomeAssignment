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
    
    private(set) var hasNext = false
    
    private(set) var isLoadingNext = false
    
    
    private var currentPage: Int = 1

    private var subscriptions: [AnyCancellable] = []
    
    
    func resetData(){
        peopleList = []
        hasNext = false
        currentPage = 1
    }
    
    func getPeople(){
        isLoadingNext = true
        showLoader = true

        NetworkManager.shared.getAllPersons(page: currentPage)
            .sink(receiveCompletion: handleCompletion, receiveValue: handlePeopleResponse)
            .store(in: &subscriptions)
        
    }
    
    private func handlePeopleResponse(response: PersonsResponse){
        
        guard !response.data.isEmpty else {
            listIsEmpty = true
            return
        }
        
        listIsEmpty = false
        
        peopleList.append(contentsOf: response.data)
        
        PersistanceService.shared.savePeopleList(list: peopleList)
        
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
    }
    
}
