//
//  StatusViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class StatusViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func logOutButton_TouchUpInside(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(SignInVC, animated: true, completion: nil)
            
        } catch let error {
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
    }

}
