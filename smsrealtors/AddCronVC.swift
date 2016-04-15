//
//  AddCronVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/9/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit

class AddCronVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var datePIC: UIDatePicker!
    
    @IBOutlet var timePIC: UIPickerView!
    
    @IBOutlet var titleTXT: UITextField!
    
    @IBOutlet var textTXT: UITextField!
    
    let timeval = ["Once","Daliy","Weekly","Monthly","Yearly"]
    var timex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePIC.delegate = self
        timePIC.dataSource = self
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeval[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeval.count
    
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timex = row
    }
    
    @IBAction func addBUT(sender: AnyObject) {
        
        var timesx: String!
        
       
        if timex == 0 {
             timesx  = "0"
            
        }
        
        if timex == 1 {
             timesx = "1"
            
        }
        if timex == 2 {
             timesx = "7"
            
        }
        if timex == 3 {
            timesx = "30"
            
        }
        if timex == 4 {
             timesx = "365"
            
        }
        
        let dateimput = datePIC.date
        
        let title = titleTXT.text
        let text = titleTXT.text
        
        
        let cronadd = crons(crons_id: 0, user_id: userdata.user_id, date: dateimput, text: text!, totype: "A", time: timesx, title: title!, hour: "9", monthly: "1")
        
        cronadd.save(userdata)
        
        
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    func showerror(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,  handler: nil )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:  nil)
    }


}
