//
//  LoginController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 10/21/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
   
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "instagramLogoWhite"))
        view.addSubview(logoImageView)
        logoImageView.contentMode = .scaleToFill
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 17, green: 154, blue:237)
        return view
    }()
    
    let emailTxt: UITextField = {
          let textField = UITextField()
          textField.placeholder = "Email"
          textField.borderStyle = .roundedRect
          //textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
          textField.font = UIFont.systemFont(ofSize: 14)
          textField.keyboardType = UIKeyboardType.emailAddress
          textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
       
          return textField
          
      }()
    
    let passwordTxt: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            //textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
            return textField
            
        }()
    
    @objc func handleTextInputChange()
    {
        let isFormValid = emailTxt.text?.count ?? 0 > 0 && passwordTxt.text?.count ?? 0 > 0
        
        if isFormValid
        {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue:237)
        }
        else
        {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue:244)
        }
    }
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    @objc func handleLogin(){
        guard let email = emailTxt.text else {return}
        guard let password = passwordTxt.text else {return}
//        let user = Auth.auth().currentUser
//        let uid = user?.uid
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print("Failed to sign in with this email: ", error)
                return
            }
            
            print("Successfully logged back in with user: ", authResult?.user.uid ?? "")
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
            
            mainTabBarController.setupViewControllers()
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) ])
       
        attributedText.append(NSAttributedString(string: "Sign Up.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue:237), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(pressSignUpButton), for: .touchUpInside)
        return button
    }()
    
    @objc func pressSignUpButton() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields(){
        let stackView = UIStackView(arrangedSubviews: [emailTxt, passwordTxt, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 140)
        
    }
    
}





