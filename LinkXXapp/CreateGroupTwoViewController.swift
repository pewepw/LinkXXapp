//
//  CreateGroupTwoViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit

class CreateGroupTwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func takePhotoButton_TouchUpInside(_ sender: Any) {
    }
    
    @IBAction func chooseFromGalleryButton_TouchUpInside(_ sender: Any) {
    }
    
    @IBAction func setLaterButton_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "Create_SegueThree", sender: nil)
    }
    
    @IBAction func backButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
