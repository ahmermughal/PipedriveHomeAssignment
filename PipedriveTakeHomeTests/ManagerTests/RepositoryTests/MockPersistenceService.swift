//
//  MockPersistenceService.swift
//  PipedriveTakeHomeTests
//
//  Created by Ahmer Akhter on 02/07/2023.
//

import Foundation
@testable import PipedriveTakeHome


class MockPersistenceService: PersistenceServiceProtocol {
    var invokedSavePeopleListCount = 0
    var invokedSavePeopleListParameters: ([Person])?
    
    var invokedGetPeopleListCount = 0
    var stubbedGetPeopleListResult: [Person] = []
    
    func savePeopleList(list: [Person]) {
        invokedSavePeopleListCount += 1
        invokedSavePeopleListParameters = list
    }
    
    func getPeopleList() -> [Person] {
        invokedGetPeopleListCount += 1
        return stubbedGetPeopleListResult
    }
}
