//
//  PersistenceService.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation
import Combine

class PersistenceService : PersistenceServiceProtocol{
    
    private static let peopleListKey : String = "PeopleList"
    
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
            print(error)
            return []
        }
    }
    
    func getPeopleList() -> AnyPublisher<[Person], NetworkError>{
        
        guard let data = UserDefaults.standard.data(forKey: PersistenceService.peopleListKey) else { return CurrentValueSubject([]).eraseToAnyPublisher() }
        
        do {
            let personList = try JSONDecoder().decode([Person].self, from: data)
            
            return CurrentValueSubject(personList).eraseToAnyPublisher()
        } catch {
            print(error)
            return Fail(error: .dataParseError)
                .eraseToAnyPublisher()
        }
    }
    
}
