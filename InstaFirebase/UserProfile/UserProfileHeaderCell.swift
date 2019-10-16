//
//  UserProfileHeader.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 10/13/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeaderCell: UICollectionViewCell {
  
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
        
    }()
    
    let gridButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        
    }

    var user: User?
    {
        didSet{
            setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage(){
        
       
            guard let profileImageUrl = user?.profileImageUrl else {return}
            guard let url = URL(string: profileImageUrl) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
               
                if let err = err {
                    print("Failed to fetch profile image", err)
                    return
                }
                //check for response
                guard let data = data else {return}
                let image = UIImage(data: data)
                
                //need to get back to Main thread
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }.resume()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
