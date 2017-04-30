//
//  GroupApi.swift
//  LinkXXapp
//
//  Created by Harry Ng on 01/05/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GroupApi {
    
    var REF_GROUP = FIRDatabase.database().reference().child("groups")
    
    func observeGroup(withId id:String, completion: @escaping (Group) -> Void) {
        REF_GROUP.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let group = Group.transformGroup(dict: dict, key: snapshot.key)
                completion(group)
            }
        })
    }

}
