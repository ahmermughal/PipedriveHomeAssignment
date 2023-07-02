//
//  PersistenceService.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation
import Combine

class PersistenceService : PersistenceServiceProtocol{
    
    static let peopleListKey : String = "PeopleList"
    
    static let shared = PersistenceService()
    
    private init(){}
    
    
    func savePeopleList(list: [Person]){
        let data = try? JSONEncoder().encode(list)

        UserDefaults.standard.set(data, forKey: PersistenceService.peopleListKey)
    }
    
    func getPeopleList() -> [Person]{
        
        guard let data = UserDefaults.standard.data(forKey: PersistenceService.peopleListKey) else { return [] }
        
        do {
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            return []
        }
    }
    
}
