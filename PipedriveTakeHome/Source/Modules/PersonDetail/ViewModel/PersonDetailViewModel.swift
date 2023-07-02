//
//  PersonDetailViewModel.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import Foundation


/// Serves as a view model that handles the presentation of contact information for a person.
/// It initializes with a `Person` object and sets up the contactList property, which holds tuples representing contact categories (such as phone numbers or emails) and the corresponding contact details.
class PersonDetailViewModel {
    
    // MARK: Variables
    
    /// Declares a constant named person of type Person, representing the person for whom the view model is created.
    let person: Person

    /// Declares a variable named contactList, which is an array of tuples. Each tuple has a title string and an array of PersonContact objects.
    var contactList: [(title: String, contact: [PersonContact])] = []


    // MARK: Publishers
    /// Declares a private(set) published property named listIsEmpty of type Bool, which indicates whether the contact list is empty.
    @Published private(set) var listIsEmpty: Bool?

    // MARK: Init
    init(person: Person) {

        /// Assigns the provided person to the person property.
        self.person = person

        /// Calls the setupContactList() method to populate the contactList with the person's contact information.
        setupContactList()
    }
    
    // MARK: Function
    
    /// Defines a method named `setupContactList`, responsible for setting up the contactList property.
    func setupContactList() {

        /// Retrieves the phone numbers associated with the person.
        let phoneNumbers = person.getPhoneNumbers()

        /// Retrieves the emails associated with the person.
        let emails = person.getEmails()

        /// Checks if there are any phone numbers available.
        if !phoneNumbers.isEmpty {

            /// Appends a tuple to the contactList array with the title "phone" and the person's phone numbers.
            contactList.append((title: StringConstant.phone, contact: person.phone))
        }

        /// Checks if there are any emails available.
        if !emails.isEmpty {
            
            /// Appends a tuple to the contactList array with the title "email" and the person's email addresses.
            contactList.append((title: StringConstant.email, contact: person.email))
        }

        /// Sets the value of listIsEmpty based on whether the contactList is empty or not.
        listIsEmpty = contactList.isEmpty
    }
}

