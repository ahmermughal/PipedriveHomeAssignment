//
//  MockNetworkManager.swift
//  PipedriveTakeHomeTests
//
//  Created by Ahmer Akhter on 02/07/2023.
//

import Foundation
import Combine
@testable import PipedriveTakeHome

class MockNetworkManager: NetworkManagerProtocol {
    
    var invokedGetAllPersonsCount = 0
    var stubbedGetAllPersonsResult: Result<PersonsResponse, NetworkError>!
    
    func getAllPersons(page: Int) -> AnyPublisher<PersonsResponse, NetworkError> {
        invokedGetAllPersonsCount += 1
        return Future<PersonsResponse, NetworkError> { promise in
            promise(self.stubbedGetAllPersonsResult)
        }
        .eraseToAnyPublisher()
    }
}
