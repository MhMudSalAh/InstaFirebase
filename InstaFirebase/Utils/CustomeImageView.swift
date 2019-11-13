//
//  CustomeImageView.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/8/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit

class CustomeImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    var imageCash = [String: UIImage]()
    func loadImage(urlString: String){
            
        lastURLUsedToLoadImage = urlString
        
        if let cashedImage = imageCash[urlString] {
            self.image = cashedImage 
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Failed to fetch post image: ",error)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage
            {
                return
            }

            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            
            self.imageCash[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }).resume()
        
    }
    
}
