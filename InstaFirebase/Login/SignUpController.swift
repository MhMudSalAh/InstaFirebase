//
//  ViewController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 9/10/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let loadPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "loadPhotoImg").withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor.black
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(handleLoadPhoto), for: .touchUpInside)
        return button
        
    }()
    
    @objc func handleLoadPhoto()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        if let editedImage = info[.editedImage] as? UIImage
        {
         loadPhoto.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if let originalImage = info[.originalImage] as? UIImage
        {
            loadPhoto.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        loadPhoto.layer.cornerRadius = loadPhoto.frame.width/2
        loadPhoto.layer.masksToBounds = true
        loadPhoto.layer.borderColor = UIColor.black.cgColor
        loadPhoto.layer.borderWidth = 2
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    let emailTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
  //      textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
     
        return textField
        
    }()
    
    @objc func handleTextInputChange()
    {
        let isFormValid = emailTxt.text?.count ?? 0 > 0 && userNameTxt.text?.count ?? 0 > 0 && passwordTxt.text?.count ?? 0 > 0
        
        if isFormValid
        {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue:237)
        }
        else
        {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue:244)
        }
    }
    
    let passwordTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
//        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
        
    }()
    
    let userNameTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
//        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
        
    }()
    
    
    let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    
    @objc func handleSignUp()
    {
        
        guard let userName = userNameTxt.text, userName.count > 0 else {return}
        guard let email = emailTxt.text, email.count > 0 else {return}
        guard let password = passwordTxt.text, password.count > 0 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error
            {
                print("Failed to create user:",err)
                return
            }
            
            print("successfuly created user:", authResult?.user.uid ?? "")
            
            guard let image = self.loadPhoto.imageView?.image else {return}
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else{return}

            let fileName = NSUUID().uuidString
            let imageRef = Storage.storage().reference().child("profile_image").child(fileName)
            imageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil
                {
                    print("Failed to upload profile image: ", error)
                    return
                }
                
            imageRef.downloadURL(completion: { (url, err) in
                guard let url = url else {return}
                let imgRef = url.absoluteString
                let user = Auth.auth().currentUser
                guard let userId = user?.uid else {return}
                let dictionaryValues: [String: Any] = ["userName": userName, "profileImageUrl": imgRef]
                let values = [userId: dictionaryValues]
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err
                        {
                            print("Failed to save user info to database: ", err)
                            return
                        }

                        print("Successful to save user info to database")
                        
                        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                        
                        mainTabBarController.setupViewControllers()
                        
                        self.dismiss(animated: true, completion: nil)
                    
                    })
                })
                
            }
        }
    }
    
    let AlreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedText = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) ])
       
        attributedText.append(NSAttributedString(string: "Sign In.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue:237), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccountButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAlreadyHaveAccountButton(){
       _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(AlreadyHaveAccountButton)
        AlreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.backgroundColor = .white
        view.addSubview(loadPhoto)
        
        loadPhoto.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        loadPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  
        
        setupInputFields()

    }

    fileprivate func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTxt, userNameTxt, passwordTxt, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: loadPhoto.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 200)
    }
    

}









