//
//  SmsmemberVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 3/28/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit
import Alamofire
import iAd


class SmsmemberVC: UIViewController {
    
    @IBOutlet var textTXT: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if  userdata.user_id == 0 {
            self.showerror("Login", message: "You must be logged in")
            self.navigationController?.popViewControllerAnimated(true)
        }
    }


 
    @IBAction func sendclickBUT(sender: AnyObject) {
        
        if textTXT.text != "" {
            if let pwd = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String {
                
                    let urlstr = "\(REF_SMSMEMBERS_URL)user_id=\(userdata.user_id)&pwd=\(pwd)"
                         Alamofire.request(.GET, urlstr, parameters: ["text": self.textTXT.text!])
                    
                    self.navigationController?.popViewControllerAnimated(true)
            }
   
            
        }
        
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
