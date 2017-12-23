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
import MessageUI

class ViewController: UIViewController {
    
   // @IBAction func contactListPressed(_ sender: Any) {
        //let contactPickerViewController = CNContactPickerViewController()
        //contactPickerViewController.delegate = self as? CNContactPickerDelegate
        //present(contactPickerViewController, animated: true, completion: nil)
   // }
    
    @IBAction func addContactPressed(_ sender: Any) {
    }
    
    let contactManager = CNContactStore()
    let newContact = CNMutableContact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.delegate = self as? CNContactPickerDelegate
        //present(contactPickerViewController, animated: false, completion: nil)
        
        authorizeContactsPermission()
    }
    
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out my app"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
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
