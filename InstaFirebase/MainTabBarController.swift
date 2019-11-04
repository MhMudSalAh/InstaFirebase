//
//  MainTabBarController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 10/8/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
                
        let index = viewControllers?.firstIndex(of: viewController)
         if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let photoSelectorNavController = UINavigationController(rootViewController: photoSelectorController)
            photoSelectorNavController.modalPresentationStyle = .fullScreen
            present(photoSelectorNavController, animated: true, completion: nil)
            return false
        }
        return true
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // Always adopt a light interface style.
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        tabBar.tintColor = #colorLiteral(red: 0.05490196078, green: 0.6039215686, blue: 0.9294117647, alpha: 1)
        tabBar.unselectedItemTintColor = .black
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        setupViewControllers()
    }
    
    func setupViewControllers(){
        
       // tabBar.tintColor = .black
        //HomeVC
        
        let homeVC = templateNavController(unSelectedImage: #imageLiteral(resourceName: "homeUnselected"), selectedImage: #imageLiteral(resourceName: "homeSelected"))
        
        //searchVC
        let searchVC = templateNavController(unSelectedImage: #imageLiteral(resourceName: "searchUnSelected"), selectedImage: #imageLiteral(resourceName: "searchSelected"))
        
        //cameraVC
        let cameraVC = templateNavController(unSelectedImage: #imageLiteral(resourceName: "plusUnSelected"), selectedImage: #imageLiteral(resourceName: "plusSelected"))
        
        //likeVC
        let likeVC = templateNavController(unSelectedImage: #imageLiteral(resourceName: "likeUnSelected"), selectedImage: #imageLiteral(resourceName: "likeSelected"))
        
        //userProfileVC
        let layout = UICollectionViewFlowLayout()
               let userProfileVC = UserProfileController(collectionViewLayout: layout)
               let userProfileNavController = UINavigationController(rootViewController: userProfileVC)
               
               userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "userProfileUnselected")
               userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "userprofileSelected")
              
               
               viewControllers = [homeVC,
                                  searchVC,
                                  cameraVC,
                                  likeVC,
                                  userProfileNavController]
        
        guard let items = tabBar.items else {return}
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    fileprivate func templateNavController(unSelectedImage: UIImage, selectedImage: UIImage) -> UINavigationController {
        
        let VC = UIViewController()
        let navController = UINavigationController(rootViewController: VC)
        navController.tabBarItem.image = unSelectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }

}
