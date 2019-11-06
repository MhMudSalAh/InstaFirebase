//
//  SharePhotoController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/4/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.6039215686, blue: 0.9294117647, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleToFill
      //  image.clipsToBounds = true
        return image
    }()
    
    let textView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .none
        text.font = UIFont.systemFont(ofSize: 14)
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        text.layer.borderColor = color
        text.layer.borderWidth = 2
        text.layer.cornerRadius = 5
        return text
    }()
    
    fileprivate func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.6039215686, blue: 0.9294117647, alpha: 1)
        
        view.addSubview(containerView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: -2, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleShare(){
        
      //  guard let caption = textView.text, caption.count > 0 else {return}
      
        guard let image = selectedImage else {return}
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else{return}
        navigationItem.rightBarButtonItem?.isEnabled = false
        let fileName = NSUUID().uuidString
        let imageRef = Storage.storage().reference().child("posts").child(fileName)
        imageRef.putData(uploadData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload post image: ",error)
                return
            }
            imageRef.downloadURL(completion: { (url, err) in
                guard let url = url else {return}
                let imgRef = url.absoluteString
                print("Successfully upload post image: ", imgRef)
                
                self.savetoDatabaseWithImageUrl(imageUrl: imgRef)
            })

        }
        
    }
    
    fileprivate func savetoDatabaseWithImageUrl(imageUrl: String){
        
//        let nameForUser = UserProfileHeaderCell()
//        let userName = Storage.storage()
        
        guard let caption = textView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postImage = selectedImage else {return}
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values: [String: Any] = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHight": postImage.size.height, "creationDate": Date.timeIntervalBetween1970AndReferenceDate]
        
        ref.updateChildValues(values) { (error, ref) in
            if let error = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", error)
                return
            }
            print("Successfully to save post to DB")
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
