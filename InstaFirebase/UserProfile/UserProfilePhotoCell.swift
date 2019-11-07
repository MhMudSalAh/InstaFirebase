//
//  UserProfilePhotoCell.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/7/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            print(post?.ImageUrl ?? "")
            
            guard let imageUrl = post?.ImageUrl else {return}
            guard let url = URL(string: imageUrl) else {return}
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Failed to fetch post image: ",error)
                    return
                }
                guard let imageData = data else {return}
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                }
            }).resume()
            
        }
    }
    
    let photoImageView: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
