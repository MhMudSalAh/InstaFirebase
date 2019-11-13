//
//  HomePostCell.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/10/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post?{
        didSet {
            guard let postImageUrl = post?.ImageUrl else {return}
            photoImageView.loadImage(urlString: postImageUrl)
        }
    }
    
    let userImageView: CustomeImageView = {
        let image = CustomeImageView()
        image.backgroundColor = .darkGray
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let photoImageView: CustomeImageView = {
        let image = CustomeImageView()
        image.backgroundColor = .darkGray
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userImageView)
        userImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userImageView.layer.cornerRadius = 40 / 2
        
        addSubview(photoImageView)
        photoImageView.anchor(top: userImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
