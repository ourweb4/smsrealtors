//
//  loginVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 2/24/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit
import iAd

class loginVC: UIViewController {
    
    var usr: user!
    
    @IBOutlet var logonLB: UILabel!
    
    @IBOutlet var emailTXT: UITextField!
    
    @IBOutlet var passwordTXT: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goBack(sender:AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func logon_click(sender: AnyObject) {
        if emailTXT.text != nil && passwordTXT.text != nil {
            userdata = user(pass: passwordTXT.text!, emailx: emailTXT.text!)
            if userdata.logon() {
                NSUserDefaults.standardUserDefaults().setValue(emailTXT.text, forKey: "email")
                NSUserDefaults.standardUserDefaults().setValue(passwordTXT.text, forKey: "pwd")
                NSUserDefaults.standardUserDefaults().synchronize()
              //performSegueWithIdentifier("gohome", sender: self.usr)
              self.navigationController?.popViewControllerAnimated(true)
            }
            
            
        }
        
    }
        
    
    
    func showerror(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,  handler: nil )
        alert.addAction(action)
          presentViewController(alert, animated: true, completion:  nil)
    }
}
