//
//  Group.swift
//  LinkXXapp
//
//  Created by Harry Ng on 01/05/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit

class Group {
    
    var groupName: String?
    var category: String?
    var photoUrl: String?
    var uid: String?
    var id: String?
    
}

extension Group {
    
    static func transformGroup(dict: [String: Any], key: String) -> Group {
        let group = Group()
        
        group.groupName = dict["groupName"] as? String
        group.category = dict["category"] as? String
        group.photoUrl = dict["photoUrl"] as? String
        group.uid = dict["uid"] as? String
        group.id = key
        
        return group
    }
    
}
