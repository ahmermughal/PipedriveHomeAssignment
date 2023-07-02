//
//  PersistenceService.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation
import Combine

/// The `PersistenceService` class provides methods for saving and retrieving a list of people using `UserDefaults`. It uses `JSONEncoder` to encode the list before saving it and `JSONDecoder` to decode the data when retrieving it.
/// This class ensures that the list of people can be saved and retrieved reliably for persistent storage in the application.
/// NOTE: Replace UserDefaults with Realm or CoreData as this is not the best way to presist this type of data. Because of the scope of this project UserDefault is used.
class PersistenceService: PersistenceServiceProtocol {
    
    // MARK: - Variables
    
    static let peopleListKey: String = "PeopleList"
    
    static let shared = PersistenceService()
    
    private init() {}
    
    
    // MARK: - Functions
    
    /// Saves the provided list of people to UserDefaults.
    ///
    /// - Parameter list: The list of people to be saved.
    func savePeopleList(list: [Person]) {
        /// Encode the list of people into data using JSONEncoder
        let data = try? JSONEncoder().encode(list)

        /// Store the encoded data in UserDefaults with the peopleListKey
        UserDefaults.standard.set(data, forKey: PersistenceService.peopleListKey)
    }
    
    /// Retrieves the list of people from UserDefaults.
    ///
    /// - Returns: The list of people, or an empty array if retrieval fails.
    func getPeopleList() -> [Person] {
        /// Attempt to retrieve data associated with the peopleListKey from UserDefaults
        guard let data = UserDefaults.standard.data(forKey: PersistenceService.peopleListKey) else {
            /// If no data is found, return an empty array
            return []
        }
        
        do {
            /// Decode the retrieved data into an array of Person objects using JSONDecoder
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            /// If decoding fails, return an empty array
            return []
        }
    }
    
}
