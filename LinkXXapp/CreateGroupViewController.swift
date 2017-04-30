//
//  CreateGroupViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import SCLAlertView

class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var selectedCategory = "friends"
    var selectedGroupName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectCategoryButton.layer.cornerRadius = 5
        selectCategoryButton.clipsToBounds = true
        selectCategoryButton.layer.borderWidth = 1
        selectCategoryButton.layer.borderColor = UIColor(red: 244/255, green: 107/255, blue: 82/255, alpha: 1).cgColor
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Create_SegueTwo" {
            let createGroupTwoVC = segue.destination as? CreateGroupTwoViewController
            createGroupTwoVC?.selectedCategory = self.selectedCategory
            createGroupTwoVC?.selectedGroupName = self.selectedGroupName
        }
    }
    
    @IBAction func selectCategoryButton_TouchUpInside(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Group Category", message: "Select a group category", preferredStyle: .actionSheet)
        let family = UIAlertAction(title: "Family", style: .default) { (action) in
            self.selectCategoryButton.setTitle("Family", for: .normal)
            self.selectedCategory = action.title!
            
        }
        let friends = UIAlertAction(title: "Friends", style: .default) { (action) in
            self.selectCategoryButton.setTitle("Friends", for: .normal)
            self.selectedCategory = action.title!
        }

        actionSheet.addAction(family)
        actionSheet.addAction(friends)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func nextButton_TouchUpInside(_ sender: Any) {
       
        if groupNameTextField.text == "" {
            SCLAlertView().showTitle(
                "Unable to create group",
                subTitle: "Please enter group name",
                duration: 0.0,
                completeText: "OK",
                style: .success,
                colorStyle: 0xF26C57,
                colorTextButton: 0xFFFFFF)
        } else {
            selectedGroupName = self.groupNameTextField.text
            performSegue(withIdentifier: "Create_SegueTwo", sender: nil)
        }
        
        
    }
    
    @IBAction func backButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
