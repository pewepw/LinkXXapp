//
//  User.swift
//  LinkXXapp
//
//  Created by Harry Ng on 01/05/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import Foundation

class User {
    
    var email: String?
    var profileImageUrl: String?
    var username: String?
    var id: String?
    
}

extension User {
    
    static func transformUser(dict: [String: Any], key: String) -> User {
        let user = User()
        
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.username = dict["username"] as? String
        user.id = key
        
        return user
    }
    
}
