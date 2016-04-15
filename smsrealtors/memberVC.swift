//
//  memberVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 3/17/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit
import EVContactsPicker

class memberVC: UIViewController, EVContactsPickerDelegate {
    
    @IBOutlet var nameTXT: UITextField!
    
    @IBOutlet var cellTXT: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if  userdata.user_id == 0 {
            self.showerror("Login", message: "You must be logged in")
                 self.navigationController?.popViewControllerAnimated(true)
        }
    }

    @IBAction func addBUT(sender: AnyObject) {
        
        if nameTXT.text != "" && cellTXT.text != "" {
                   let addmember = members(member_id: 0, user_id: userdata.user_id, name: nameTXT.text!
         , cell: cellTXT.text!, opin: 0)
            addmember.save(userdata)
                self.navigationController?.popViewControllerAnimated(true)
        } else {
            self.showerror("Bad Input", message: "Name and Cell must be entered")
            
        }
        
    }
    
    @IBAction func contactsBUT(sender: AnyObject) {
        
        let contactpicker = EVContactsPickerViewController()
         contactpicker.delegate = self
        self.navigationController?.pushViewController(contactpicker, animated: true)
    }
    
    func didChooseContacts(contacts: [EVContact]?) {
        
        if let cons = contacts {
            
            for con in cons {
                if  let cell: String = con.phone! {
                    if let firstname: String = con.firstName, let lastname: String = con.lastName {
                        let name: String = "\(firstname) \(lastname)"
                let addmemer = members(member_id: 0, user_id: userdata.user_id, name: name, cell: cell, opin: 0)
                addmemer.save(userdata)
                }
                }
                
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showerror(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,  handler: { _ in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:  nil)
    }
    
    
    
}
