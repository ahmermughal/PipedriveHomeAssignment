//
//  CacheManager.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

/// The CacheManager class is a singleton class responsible for managing the caching of images.
class CacheManager{
    
    /// Create a static constant shared instance of the CacheManager class.
    static let shared = CacheManager()
    
    /// Create an instance of NSCache to store images. The key is of type NSString, and the value is of type UIImage.
    let imageCache = NSCache<NSString, UIImage>()
    
    private init(){}
    
}
