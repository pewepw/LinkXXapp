//
//  HomeViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import SCLAlertView

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
