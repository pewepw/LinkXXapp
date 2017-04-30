//
//  GroupViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import TwicketSegmentedControl

class GroupViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: TwicketSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.delegate = self
        let titles = ["Friends", "Family", "Community"]
        segmentedControl.setSegmentItems(titles)
        segmentedControl.sliderBackgroundColor = UIColor(red: 242/255, green: 108/255, blue: 87/255, alpha: 1)
       
    }
    
    @IBAction func addButton_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "Create_Segue", sender: nil)
    }

}


extension GroupViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        
    }
    
}
