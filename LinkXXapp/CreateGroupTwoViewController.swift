//
//  CreateGroupTwoViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SCLAlertView
import SVProgressHUD

class CreateGroupTwoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var chooseFromGalleryButton: UIButton!
    
    var selectedImage: UIImage?
    var selectedCategory: String?
    var selectedGroupName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takePhotoButton.layer.cornerRadius = 5
        takePhotoButton.clipsToBounds = true
        takePhotoButton.layer.borderWidth = 1
        takePhotoButton.layer.borderColor = UIColor(red: 244/255, green: 107/255, blue: 82/255, alpha: 1).cgColor
        
        chooseFromGalleryButton.layer.cornerRadius = 5
        chooseFromGalleryButton.clipsToBounds = true
        chooseFromGalleryButton.layer.borderWidth = 1
        chooseFromGalleryButton.layer.borderColor = UIColor(red: 244/255, green: 107/255, blue: 82/255, alpha: 1).cgColor

        
        
    }
    

    
    @IBAction func takePhotoButton_TouchUpInside(_ sender: Any) {
        let cameraPickerController = UIImagePickerController()
        cameraPickerController.delegate = self
        cameraPickerController.sourceType = .camera
        present(cameraPickerController, animated: true, completion: nil)
    }
    
    @IBAction func chooseFromGalleryButton_TouchUpInside(_ sender: Any) {
        let photoPickerController = UIImagePickerController()
        photoPickerController.delegate = self
        photoPickerController.sourceType = .photoLibrary
        present(photoPickerController, animated: true, completion: nil)
    }
    
    @IBAction func setLaterButton_TouchUpInside(_ sender: Any) {
        if selectedImage == nil {
            SCLAlertView().showTitle(
                "Unable to create group",
                subTitle: "Please enter group name",
                duration: 0.0,
                completeText: "OK",
                style: .success,
                colorStyle: 0xF26C57,
                colorTextButton: 0xFFFFFF)
        } else {
            
            if let groupPhoto = self.selectedImage, let imageData = UIImageJPEGRepresentation(groupPhoto, 0.1) {
                let photoIdString = NSUUID().uuidString
                let storageRef = FIRStorage.storage().reference().child("groups").child(photoIdString)
                storageRef.put(imageData, metadata: nil) { (metadata, error) in
                    if error != nil {
                        
                        SVProgressHUD.showError(withStatus: error!.localizedDescription)
                        
                        return
                    }
                    
                    if let photoUrl = metadata?.downloadURL()?.absoluteString {
                        self.sendDataToDatabase(photoUrl: photoUrl)
                    }
                }
            }

            performSegue(withIdentifier: "Create_SegueThree", sender: nil)
        }
    }
    
    func sendDataToDatabase(photoUrl: String) {
        let postId = FIRDatabase.database().reference().child("groups").childByAutoId().key
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return
        }
        let currentUserId = currentUser.uid
        let dict = ["uid": currentUserId, "groupName": selectedGroupName!,"category": selectedCategory!, "photoUrl": photoUrl] as [String : Any]
        FIRDatabase.database().reference().child("groups").child(postId).setValue(dict, withCompletionBlock: { (error, ref) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            } else {
                let myGroupsRef = Api.MyGroup.REF_MYGROUP.child(currentUserId).child(postId)
                myGroupsRef.setValue(true, withCompletionBlock: { (error, snapshot) in
                    if error != nil {
                        SVProgressHUD.showError(withStatus: error?.localizedDescription)
                    }
                })
            }
            
        })
    }

    
    
    @IBAction func backButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupTwoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            imageView.image = image
            takePhotoButton.isHidden = true
            chooseFromGalleryButton.isHidden = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
