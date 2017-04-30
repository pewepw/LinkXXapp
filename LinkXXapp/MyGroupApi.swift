//
//  MyGroupApi.swift
//  LinkXXapp
//
//  Created by Harry Ng on 01/05/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MyGroupApi {
    
    var REF_MYGROUP = FIRDatabase.database().reference().child("myGroups")
    
}
