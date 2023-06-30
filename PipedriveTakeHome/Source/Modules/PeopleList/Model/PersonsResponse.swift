//
//  PersonsResponse.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import Foundation


struct PersonsResponse{
    
    let success : Bool
    let data : [Person]
    let additionalData: AdditionalData?
    
    enum CodingKeys: String, CodingKey{
        case success
        case data
        case additionalData = "additional_data"
    }
}

struct Person : Codable {
    
    let id : Int
    let name : String?
    let organizationName : String?
    let phone : [PersonContact]
    let email : [PersonContact]
    let picture : PersonPicture?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case organizationName = "org_name"
        case phone
        case email
        case picture = "picture_id"
    }
    
}

struct PersonContact : Codable {
    
    let label : String?
    let value : String?
    let isPrimary : Bool?
    
    enum CodingKeys: String, CodingKey{
        case label
        case value
        case isPrimary = "primary"
    }
    
}

struct PersonPicture : Codable {
    
    let pictures : PictureItem?
    
}

struct PictureItem : Codable {
    
    let smallImage : String?
    let largeImage : String?
    
    enum CodingKeys: String, CodingKey{
        case smallImage = "128"
        case largeImage = "512"
    }
    
    
}

struct AdditionalData {
    let pagination : PaginationData
}

struct PaginationData {
    let start : Int
    let limit : Int
    let anyMoreItem : Bool
    
    enum CodingKeys: String, CodingKey{
        case start
        case limit
        case anyMoreItem = "more_items_in_collection"
    }
}
