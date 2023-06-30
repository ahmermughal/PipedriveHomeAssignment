//
//  UIImageView+Ext.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

extension UIImageView {
    
    @discardableResult func setImageWithUrl(url: String) -> UIImageView? {
        
        guard let url = URL(string: url) else {
            self.image = ImageConstant.profilePlaceholder
            return self
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            if let data = data, let loadedImage = UIImage(data: data)  {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }else {
                self.image = ImageConstant.profilePlaceholder
            }
        }.resume()
        
        return self
    }
    
}
