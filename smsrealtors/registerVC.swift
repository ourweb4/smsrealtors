//
//  registerVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 3/21/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit

class registerVC: UIViewController {
    
    @IBOutlet var fnameTXT: UITextField!
    @IBOutlet var lnameTXT: UITextField!
    @IBOutlet var passTXT: UITextField!
    @IBOutlet var companyTXT: UITextField!
    @IBOutlet var emailTXT: UITextField!
    @IBOutlet var addressTXT: UITextField!
    @IBOutlet var cityTXT: UITextField!
    @IBOutlet var stateTXT: UITextField!
    @IBOutlet var zipTXT: UITextField!
    @IBOutlet var phoneTXT: UITextField!
    @IBOutlet var cellTXT: UITextField!
    @IBOutlet var websiteTXT: UITextField!
    
    
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        
        if userdata.user_id !=  0 {
            fnameTXT.text = userdata.firstname
            lnameTXT.text = userdata.lastname
            passTXT.text = userdata.pass
            companyTXT.text = userdata.company
            emailTXT.text = userdata.email
            addressTXT.text = userdata.address
            cityTXT.text = userdata.city
            stateTXT.text = userdata.state
            zipTXT.text = userdata.zip
            phoneTXT.text = userdata.phone
            cellTXT.text = userdata.cell
            websiteTXT.text = userdata.website
            
        }
    }
    
    @IBAction func signupBUT(sender: AnyObject) {
        if fnameTXT.text != "" && lnameTXT.text != "" && emailTXT.text != "" && passTXT.text != "" && phoneTXT.text != "" && cellTXT.text != "" {
            if userdata.user_id == 0 {
                userdata.firstname = fnameTXT.text
                userdata.lastname = lnameTXT.text
                userdata.pass = passTXT.text
                userdata.company = companyTXT.text
                userdata.email = emailTXT.text
                userdata.address = addressTXT.text
                userdata.city = cityTXT.text
                userdata.state = stateTXT.text
                userdata.zip = zipTXT.text
                userdata.phone = phoneTXT.text
                userdata.cell = cellTXT.text
                userdata.notfiy = 3
                userdata.leftmsg = 1000
                userdata.website = websiteTXT.text
                    if !userdata.save() {
                        self.showerror("Save error", message: "There is an error in saving. You are not registered.")
                    }  else {
                        
                        NSUserDefaults.standardUserDefaults().setValue(emailTXT.text, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(passTXT.text, forKey: "pwd")
                        NSUserDefaults.standardUserDefaults().synchronize()
                            self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
        } else {
            self.showerror("BAD INPUT", message: "You must enter in *field")
        }
    }
    
    func showerror(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,  handler: nil )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:  nil)
    }
    
    
}
