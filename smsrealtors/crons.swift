//
//  crons.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/6/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import Foundation
import Alamofire

class crons {
    var crons_id: UInt!
    var user_id: UInt!
    var date: NSDate!
    var text: String!
    var totype: String!
//    var group_id: UInt!
    var time: String!
    var title: String!
    var hour: String!
    var monthly: String!
    
    init(crons_id: UInt, user_id: UInt, date: NSDate, text: String, totype: String, time: String, title: String, hour: String, monthly: String) {
        
        self.crons_id = crons_id
        self.user_id = user_id
        self.date = date
        self.text = text
        self.totype = totype
        self.time = time
        self.title = title
        self.hour = hour
        self.monthly = monthly
        
    }
    
    
    
    func save(usr: user) {
        if let pwd = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String {
            if self.user_id != 0 {
                let urlstr = "\(REF_ADDCRON_URL)user_id=\(self.user_id)&pwd=\(pwd)"
                Alamofire.request(.GET, urlstr, parameters: ["date": self.date,
                    "totype": self.totype,
                    "text": self.text,
                    "time": self.time,
                    "title": self.title,
                     "hour": self.hour,
                    "monthly": self.monthly])
                
                
                
                
            }
        }
        
    }
    
    
    func delete() {
        if let pwd = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String {
            if self.user_id != 0 {
                let urlstr = "\(REF_DELCRON_URL)user_id=\(self.user_id)&pwd=\(pwd)&cron_id=\(self.crons_id)"
                //                let url = NSURL(string: urlstr)
                Alamofire.request(.GET, urlstr)
                
                
                
                
            }
        }
    }

    
    
    
    
}