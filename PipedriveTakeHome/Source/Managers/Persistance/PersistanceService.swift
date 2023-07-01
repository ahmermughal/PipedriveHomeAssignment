//
//  PersistanceService.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation


class PersistanceService{
    
    private static let peopleListKey : String = "PeopleList"
    
    static let shared = PersistanceService()
    
    private init(){}
    
    
    func savePeopleList(list: [Person]){
        let data = try? JSONEncoder().encode(list)

        UserDefaults.standard.set(data, forKey: PersistanceService.peopleListKey)
    }
    
    func getPeopleList() -> [Person]{
        
        guard let data = UserDefaults.standard.data(forKey: PersistanceService.peopleListKey) else { return [] }
        
        do {
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
}
