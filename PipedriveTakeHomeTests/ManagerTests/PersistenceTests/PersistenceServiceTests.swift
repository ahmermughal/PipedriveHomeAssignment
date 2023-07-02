//
//  PersistenceServiceTests.swift
//  PipedriveTakeHomeTests
//
//  Created by Ahmer Akhter on 02/07/2023.
//

import XCTest
@testable import PipedriveTakeHome

final class PersistenceServiceTests: XCTestCase {

    var service: PersistenceService!

    override func setUpWithError() throws {
        // GIVEN
        service = PersistenceService.shared
        UserDefaults.standard.removeObject(forKey: PersistenceService.peopleListKey)

    }

    override func tearDownWithError() throws {
        service = nil
    }

    /// This is a test function for the `savePeopleList` function of the `PersistenceService` class. It tests whether the function can successfully save a provided list of `Person`. Here's a breakdown of the different sections:
    /// - GIVEN: `PersistenceService` instance and the absence of any previously saved data in UserDefaults.
    /// - WHEN: This section sets up the input for the `savePeopleList` function. A sample list of `Person`  with three entries is setup. The `savePeopleList` method of the `PersistenceService` instance is called with the sample list as an argument. This saves the list to the persistence layer. Test case retrieves the saved data from UserDefaults using the key `PersistenceService.peopleListKey` and assigns it to the savedData variable.
    /// - THEN: This section checks the output of the `savePeopleList` function by comparing the retrieved list to the sample list.
    func testSavePeopleList_WhenValidListProvided_ThenSavedPersonsEqualsCurrentPersons() {
        // WHEN
        
        /// Create a sample list of Person objects
        let peopleList = [
            Person(id: 1, name: "John", organizationName: "Org", phone: [], email: [], picture: nil),
            Person(id: 2, name: "Jane", organizationName: "Org", phone: [], email: [], picture: nil),
            Person(id: 3, name: "Mark", organizationName: "Org", phone: [], email: [], picture: nil)
        ]
        
        /// Call the savePeopleList method with the peopleList
        service.savePeopleList(list: peopleList)
        
        /// Retrieve the saved data from UserDefaults
        let savedData = UserDefaults.standard.data(forKey: PersistenceService.peopleListKey)
        
        // THEN
        
        /// Assert that savedData is not nil
        XCTAssertNotNil(savedData)
        
        /// Decode the savedData into an array of Person objects
        let decodedList = try? JSONDecoder().decode([Person].self, from: savedData!)
        
        /// Assert that the decodedList is equal to the original peopleList
        XCTAssertEqual(decodedList, peopleList)
    }

    
    /// This is a test function for the `getPeopleList` function of the `PersistenceService` class. It tests whether the function can successfully retrieve a saved list of `Person`. Here's a breakdown of the different sections:
    /// - GIVEN: `PersistenceService` instance and the absence of any previously saved data in UserDefaults.
    /// - WHEN: This section sets up a sample list and is saved to UserDefaults using the key `PersistenceService.peopleListKey`.  The list is then retrieved using `getPeopleList` function.
    /// - THEN: This section checks whether `getPeopleList` output retrieved the data correctly by checking the saveData varaible is not nil and comparing the sample list to the retrived saved list.
    func testGetPeopleList_WhenValidListIsSaved_ThenSavedPersonsCurrentPersons() {
        // WHEN
        
        /// Create a sample list of Person objects
        let peopleList = [
            Person(id: 1, name: "John", organizationName: "Org", phone: [], email: [], picture: nil),
            Person(id: 2, name: "Jane", organizationName: "Org", phone: [], email: [], picture: nil),
            Person(id: 3, name: "Mark", organizationName: "Org", phone: [], email: [], picture: nil)
        ]
        
        /// Encode the peopleList into data using JSONEncoder
        let encodedData = try? JSONEncoder().encode(peopleList)
        
        /// Save the encodedData to UserDefaults using the PersistenceService.peopleListKey as the key
        UserDefaults.standard.set(encodedData, forKey: PersistenceService.peopleListKey)
        
        /// Retrieve the list of people from the service
        let retrievedList = service.getPeopleList()
        
        // THEN
        
        /// Assert that the retrievedList is equal to the original peopleList
        XCTAssertEqual(retrievedList, peopleList)
    }

    
    /// This is a test function for the `getPeopleList` function of the `PersistenceService` class. It tests whether the function can successfully return an empty list when no data is saved in UserDefault. Here's a breakdown of the different sections:
    /// - GIVEN: `PersistenceService` instance and the absence of any previously saved data in UserDefaults.
    /// - WHEN: No saved data exists in UserDefault. The `getPeopleList` function is used to retrieve data.
    /// - THEN: This section checks whether `getPeopleList` retrieved an empty list when no save data exist.
    func testGetPeopleList_WhenNoPersonsProvided_ThenSavedPersonEqualEmptyList() {
        // WHEN
        /// Retrieve the list of people from the service
        let retrievedList = service.getPeopleList()
        
        // THEN
        /// Assert that the retrievedList is equal to an empty
        XCTAssertEqual(retrievedList, [])
    }
    
    /// This is a test function for the `getPeopleList` function of the `PersistenceService` class. It tests whether the function can successfully return an empty list when invalid data is saved in UserDefault. Here's a breakdown of the different sections:
    /// - GIVEN: `PersistenceService` instance and the absence of any previously saved data in UserDefaults.
    /// - WHEN: Invalid data is saved in UserDefaults using the key `PersistenceService.peopleListKey` . The `getPeopleList` function is used to retrieve data.
    /// - THEN: This section checks whether `getPeopleList` retrieved an empty list when invalid data exists.
    func testGetPeopleList_WhenInvaliDataProvided_ThenReturnEmpty() {
        // WHEN
        /// Invalid data is saved to UserDefault
        let invalidData = Data("InvalidData".utf8)
        UserDefaults.standard.set(invalidData, forKey: PersistenceService.peopleListKey)
        
        /// Retrieve the list of people from the service
        let retrievedList = service.getPeopleList()
        
        // THEN
        /// Assert that the retrievedList is equal to an empty
        XCTAssertEqual(retrievedList, [])
    }

}
