//
//  HomeViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SCLAlertView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    var groups: [Group] = []
    var users: [User] = []
    var groupId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosts()
        
    }
    
    func loadPosts() {
        Api.Group.observeGroup(withId: groupId!, completion: { (group) in
            self.fetchUser(uid: group.uid!, completed: {
                
                self.groupNameLabel.text = group.groupName
                if let photoUrlString = group.photoUrl {
                    let photoUrl = URL(string: photoUrlString)
                    self.groupImageView.sd_setImage(with: photoUrl)
                }
            })
        })
    }
    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUser(dict: dict, key: snapshot.key)
                self.users.append(user)
                completed()
            }
        })
    }
    
    @IBAction func followMeButton_TouchUpInside(_ sender: Any) {
        SCLAlertView().showTitle(
            "Exicting Feature",
            subTitle: "Coming Soon",
            duration: 0.0,
            completeText: "OK",
            style: .success,
            colorStyle: 0xF26C57,
            colorTextButton: 0xFFFFFF)
    }
    
    @IBAction func chatButton_TouchUpInside(_ sender: Any) {
        SCLAlertView().showTitle(
            "Exicting Feature",
            subTitle: "Coming Soon",
            duration: 0.0,
            completeText: "OK",
            style: .success,
            colorStyle: 0xF26C57,
            colorTextButton: 0xFFFFFF)
    }
    
    @IBAction func panicButton_TouchUpInside(_ sender: Any) {
        SCLAlertView().showTitle(
            "Exicting Feature",
            subTitle: "Coming Soon",
            duration: 0.0,
            completeText: "OK",
            style: .success,
            colorStyle: 0xF26C57,
            colorTextButton: 0xFFFFFF)
    }
}

//extension HomeViewController: GroupCollectionViewCellDelegate {
//    func pass(groupId: String) {
//        self.groupId = groupId
//    }
//}

