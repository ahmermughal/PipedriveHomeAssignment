//
//  NetworkManager.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation
import Combine


class NetworkManager : NetworkManagerProtocol{
    
    static let shared = NetworkManager()
    
    private let networkService = NetworkService()
    private init() {}
    

    func getAllPersons(page: Int = 1) -> AnyPublisher<PersonsResponse, NetworkError>{

        return networkService.performRequest(apiType: .getAllPersons, resultType: PersonsResponse.self)
    }

    
}
