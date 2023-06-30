//
//  CacheManager.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

class CacheManager{
    
    static let shared = CacheManager()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private init(){}
    
}
