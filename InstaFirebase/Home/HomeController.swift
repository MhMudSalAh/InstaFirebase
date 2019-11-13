//
//  HomeController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/10/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItem()
        
        fetchPosts()
    }
    
    func setupNavigationItem() {
        
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "instagramLogoWhite"))
        
    }
    
    var posts = [Post]()
    
    fileprivate func fetchPosts(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            
            dictionaries.forEach { (arg) in
                
                let (_, value) = arg
                guard let dictionary = value as? [String: Any] else {return}
                let imageUrl = dictionary["imageUrl"] as? String
                print("imageUrl (\(imageUrl ?? ""))")
                
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
            }
            self.collectionView.reloadData()
        }) { (error) in
            print("Failed to fetch posts: ",error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
}
