//
//  UIImageView+Ext.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

extension UIImageView {
    
    /// Method to set image from URL asynchronously. It is marked as @discardableResult so that Xcode does not throw warning
    /// - Parameters:
    ///   - url: the intended url of the image to be loaded into the imageview
    /// - Returns: returns the instance of the current imageview
    @discardableResult func setImageWithUrl(url: String) -> UIImageView? {
        
        /// Create a cache key based on the URL
        let cacheKey = NSString(string: url)
        
        /// Check if the image exists in the cache
        if let image = CacheManager.shared.imageCache.object(forKey: cacheKey) {
            /// If found in cache, set the image directly
            self.image = image
            return self
        }
        
        /// If the image is not found in the cache, continue with fetching the image from the URL
        /// Check if a valid URL can be created from the given string
        guard let url = URL(string: url) else {
            /// If URL creation fails, set a placeHolderImage and return the current instance of UIImageView
            self.image = ImageConstant.profilePlaceholder
            return self
        }

        /// Create a data task using URLSession to fetch the image data from the URL asynchronously
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            /// Check if there is no error and data is not nil
            if let error = error {
                /// Handle any error that occurred during the data task
                print("Error loading image: \(error)")
                return
            }
            
            /// If data is available, create a UIImage from the data
            if let data = data, let loadedImage = UIImage(data: data)  {
                
                /// Store the loaded image into the cache using the cache key
                CacheManager.shared.imageCache.setObject(loadedImage, forKey: cacheKey)

                DispatchQueue.main.async {
                    /// Update the UIImageView's image property on the main queue
                    self.image = loadedImage
                }
                
            }else {
                self.image = ImageConstant.profilePlaceholder
            }
        }.resume() /// Start the data task
        
        /// Return the current instance of UIImageView
        return self
    }
    
}
