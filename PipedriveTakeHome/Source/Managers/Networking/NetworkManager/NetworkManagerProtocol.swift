//
//  NetworkManagerProtocol.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation


import Foundation
import Combine



protocol NetworkManagerProtocol{
    

    func getAllPersons(page: Int) -> AnyPublisher<PersonsResponse, NetworkError>


  
}
