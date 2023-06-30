//
//  PeopleListViewModel.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation

enum Section{
    case main
}

class PeopleListViewModel{
    
    @Published private(set) var peopleList: [String] = []

    
    func getPeople(){
        
        peopleList = ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5"]
        
    }
    
}
