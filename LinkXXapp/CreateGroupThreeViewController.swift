//
//  CreateGroupThreeViewController.swift
//  LinkXXapp
//
//  Created by Harry Ng on 30/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import SVProgressHUD

class CreateGroupThreeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        
    }
    @IBAction func selectContactsButton_TouchUpInside(_ sender: Any) {
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType )
        
        if authStatus == CNAuthorizationStatus.notDetermined {
            let contactStore = CNContactStore()
            contactStore.requestAccess(for: entityType, completionHandler: { (success, error) in
                if success {
                    self.openContacts()
                } else {
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                }
            })
        } else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
    }
    
    func openContacts() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
    
    @IBAction func backButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupThreeViewController: CNContactPickerDelegate {
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
       let fullname = "\(contact.givenName) \(contact.familyName)"
        contacts.append(fullname)
        tableView.reloadData()
    }
}

extension CreateGroupThreeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! AddressBookTableViewCell
        
        cell.nameLabel.text = contacts[indexPath.row]
        
        return cell
    }
}
