//
//  ViewController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 9/10/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let loadPhoto: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "loadPhotoImg").withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handleLoadPhoto), for: .touchUpInside)
        return button
        
    }()
    
    @objc func handleLoadPhoto()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        print(originalImage?.size)
    }
    
    let emailTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
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
            signUpButton.backgroundColor = UIColor.rgb(red: 113, green: 125, blue:255)
        }
    }
    
    let passwordTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
        
    }()
    
    let userNameTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
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
            
            let userNameValues = ["userName": userName]
            let user = Auth.auth().currentUser
            guard let userId = user?.uid else {return}
            let values = [userId: userNameValues]
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err
                {
                    print("Failed to save user info to database, err")
                    return
                }
                
                print("Successful to save user info to database")
                
            })
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


extension UIView{
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat)
    {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top
        {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left
        {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom
        {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right
        {
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if width != 0
        {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0
        {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}






