//
//  ViewController.swift
//  app-permissions-lab
//
//  Created by Westley Lashley on 3/29/17.
//  Copyright © 2017 Westley Lashley. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController {
    
    @IBAction func contactListPressed(_ sender: Any) {
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.delegate = self as? CNContactPickerDelegate
        present(contactPickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func addContactPressed(_ sender: Any) {
        
        
    }
    
    let contactManager = CNContactStore()
    
    let newContact = CNMutableContact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeContactsPermission()

    }
    
    func addNewContact() {
        newContact.givenName = ""
        newContact.familyName = ""
        newContact.nickname = ""
        if let image = UIImage(named: "logo-apps-foundation"),
        let data = UIImagePNGRepresentation(image){
        newContact.imageData = data
    }
}
    
    
    
    func authorizeContactsPermission() {
        
        contactManager.requestAccess(for: .contacts) { (bool, error) in
            guard error == nil else {return}
            if bool {
                print("Contacts authorized")
            }
            else {
                print("Contacts denied")
            }
        }
    }
}

extension ViewController: CNContactPickerDelegate {

}
