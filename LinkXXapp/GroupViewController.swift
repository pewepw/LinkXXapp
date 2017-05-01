//
//  GroupViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import TwicketSegmentedControl
import SVProgressHUD

class GroupViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: TwicketSegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups: [Group] = []
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.delegate = self
        let titles = ["Friends", "Family", "Community"]
        segmentedControl.setSegmentItems(titles)
        segmentedControl.sliderBackgroundColor = UIColor(red: 242/255, green: 108/255, blue: 87/255, alpha: 1)
        
        collectionView.dataSource = self
        collectionView.delegate = self
       
        loadPosts()
    }
    
    func loadPosts() {
        if let currentUser = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("myGroups").child(currentUser.uid).observe(.childAdded, with: { (snapshot) in
                SVProgressHUD.show()
                let groupId = snapshot.key
                Api.Group.observeGroup(withId: groupId, completion: { (group) in
                    self.fetchUser(uid: group.uid!, completed: {
                        self.groups.append(group)
                        SVProgressHUD.dismiss()
                        self.collectionView.reloadData()
                    })
                })
            })
        }
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

    
    @IBAction func addButton_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "Create_Segue", sender: nil)
    }

}


extension GroupViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        
    }
    
}

extension GroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCollectionViewCell
        let group = groups[indexPath.row]
        cell.group = group
        cell.groupVC = self
        
        return cell
    }

    
}

extension GroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
