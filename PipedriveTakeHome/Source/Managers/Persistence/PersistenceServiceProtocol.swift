//
//  PersistenceServiceProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation

protocol PersistenceServiceProtocol {
    
    func savePeopleList(list: [Person])
    
    func getPeopleList() -> [Person]
}
