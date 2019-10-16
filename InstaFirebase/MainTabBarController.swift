//
//  MainTabBarController.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 10/8/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "userProfileUnselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "userprofileSelected")
        tabBar.tintColor = .black
        
        viewControllers = [navController, UIViewController()]
        
    }
    
}
