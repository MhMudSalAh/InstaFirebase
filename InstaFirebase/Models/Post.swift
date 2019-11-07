//
//  Post.swift
//  InstaFirebase
//
//  Created by MhMuD SalAh!! on 11/7/19.
//  Copyright © 2019 Mahmoud Salah. All rights reserved.
//

import Foundation

struct Post {
    let ImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.ImageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
