//
//  SignInViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 Seek95. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "Login_Segue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        
             
        handleTextField()
        
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    func textFieldDidChange() {
        guard !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! else {
            loginButton.isEnabled = false
            return
        }
        
        loginButton.isEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func loginButton_TouchUpInside(_ sender: Any) {
        
        view.endEditing(true)
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "Login_Segue", sender: nil)
            }
        })
    }
    
    @IBAction func signUpButton_TouchUpInside(_ sender: Any) {
         performSegue(withIdentifier: "SignUp_Segue", sender: nil)
    }
   
    
}
