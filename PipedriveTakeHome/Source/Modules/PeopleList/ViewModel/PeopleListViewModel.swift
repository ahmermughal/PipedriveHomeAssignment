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
    
    private var subscriptions: [AnyCancellable] = []
    
    func getPeople(){
        
        NetworkManager.shared.getAllPersons()
            .sink(receiveCompletion: handleCompletion, receiveValue: handlePeopleResponse)
            .store(in: &subscriptions)
        
    }
    
    private func handlePeopleResponse(response: PersonsResponse){
        
        peopleList.append(contentsOf: response.data)
        
    }
    
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>){
        print(completion)
    }
    
}
