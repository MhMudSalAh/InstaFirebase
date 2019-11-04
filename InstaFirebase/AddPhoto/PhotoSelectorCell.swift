//
//  PhotoSelectorCell.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/1/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
       
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       // backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
