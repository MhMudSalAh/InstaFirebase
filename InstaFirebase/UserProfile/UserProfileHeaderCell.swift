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
  
    var user: User?
    {
        didSet{
            setupProfileImage()
            userNameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
        
    }()
    
    let gridButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.black
        return button
        
    }()
    
    let listButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.imageView?.contentMode = .scaleAspectFit

        return button
        
    }()
    
    let bookmarkButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.imageView?.contentMode = .scaleAspectFit

        return button
        
    }()
    
    let userNameLabel: UILabel = {
       let label = UILabel()
     //   lable.text = "username"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "9\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) ])
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) ])
        attributedText.append(NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
     
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) ])
        attributedText.append(NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        
        addSubview(userNameLabel)
        userNameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: gridButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        setupUserStatsView()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    fileprivate func setupUserStatsView(){
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: -5, width: 0, height: 50)
    }
    
    fileprivate func setupBottomToolbar(){
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -6, paddingRight: 0, width: 0, height: 30)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: -5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
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
