//
//  SignUpViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 Seek95. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    var selectedImage: UIImage?
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelecteProfileImage))
        
        profileImgView.addGestureRecognizer(tapGesture)
        profileImgView.isUserInteractionEnabled = true
        
        handleTextField()
        
    }
    
    func handleSelecteProfileImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    func textFieldDidChange() {
        guard !(usernameTextField.text?.isEmpty)! || !(emailTextField.text?.isEmpty)! || !(passwordTextField.text?.isEmpty)! else {
            signUpButton.isEnabled = false
            return
        }
        
        signUpButton.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func signUpButton_TouchUpInside(_ sender: Any) {
        
        view.endEditing(true)
        
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                } else {
                    let uid = user?.uid
                    FIRStorage.storage().reference().child("profile_image").child(uid!).put(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            SVProgressHUD.showError(withStatus: error?.localizedDescription)
                        } else {
                            let profileImageUrl = metadata?.downloadURL()?.absoluteString
                            
                            FIRDatabase.database().reference().child("users").child(uid!).setValue(["username": self.usernameTextField.text, "username_lowercase": self.usernameTextField.text?.lowercased(), "email": self.emailTextField.text, "profileImageUrl": profileImageUrl])
                            self.performSegue(withIdentifier: "Login_Segue", sender: nil)
                        }
                    })
                }
            })
        } else {
            SVProgressHUD.showError(withStatus: "Please fill in all required field.")
        }
    }
    
    
    @IBAction func backButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            profileImgView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
