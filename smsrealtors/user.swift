 //
//  user.swift
//  smsrealtors
//
//  Created by Bill Banks on 3/1/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import Foundation
import Alamofire


class user:NSObject, NSCoding {
    
    var user_id: UInt = 0  // if 0 user not login
    var firstname: String!
    var lastname: String!
    var email: String!
    var pass: String!
    var cell, phone: String!
    var notfiy: Int!
    var leftmsg: Int!
    var company, address, city, state, zip, website: String!
    
    
    
    init(pass: String, emailx: String) {
         self.pass = pass
        self.email = emailx
    }
    
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.firstname = (aDecoder.decodeObjectForKey("firstnane") as? String)!
        self.lastname = (aDecoder.decodeObjectForKey("lastnane") as? String)!
         self.user_id = (aDecoder.decodeObjectForKey("user_id") as? UInt)!
         self.pass = (aDecoder.decodeObjectForKey("pass") as? String)!
         self.email = (aDecoder.decodeObjectForKey("email") as? String)!
        self.notfiy = (aDecoder.decodeObjectForKey("notfiy") as? Int)!
        self.phone = (aDecoder.decodeObjectForKey("phone") as? String)!
        self.cell = (aDecoder.decodeObjectForKey("cell") as? String)!
        self.address = (aDecoder.decodeObjectForKey("address") as? String)!
        self.city = (aDecoder.decodeObjectForKey("city") as? String)!
        self.state = (aDecoder.decodeObjectForKey("state") as? String)!
        self.zip = (aDecoder.decodeObjectForKey("zip") as? String)!
        self.company = (aDecoder.decodeObjectForKey("company") as? String)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstname, forKey: "firstname")
        aCoder.encodeObject(self.lastname, forKey: "lastname")
        aCoder.encodeObject(self.pass, forKey: "pass")
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.user_id, forKey: "user_id")
        aCoder.encodeObject(self.phone, forKey: "phone")
        aCoder.encodeObject(self.cell, forKey: "cell")
        aCoder.encodeObject(self.notfiy, forKey: "notfiy")
        aCoder.encodeObject(self.address, forKey: "address")
        aCoder.encodeObject(self.city, forKey: "city")
        aCoder.encodeObject(self.state, forKey: "state")
        aCoder.encodeObject(self.zip, forKey: "zip")
        aCoder.encodeObject(self.website, forKey: "website")
        aCoder.encodeObject(self.company, forKey: "company")
    }
    
    func islogon()     -> Bool {
       return self.user_id != 0
    }

    func logon() -> Bool {
        
        opendb()
        
        do{
        let usersmt = try conn.prepare("SELECT * FROM users WHERE email=? AND passwd=?")
            
            let res = try usersmt.query([self.email, self.pass])
           // let rowscount = try res.readRow()?.count
            //if (rowscount != 0) {
                if  let row = try res.readRow() {
//                   print(row)
                 self.user_id  = (row["user_id"] as? UInt)!
                self.firstname = (row["fname"] as? String)!
                self.lastname = (row["lname"] as? String)!
                self.phone = (row["phone"] as? String)!
                self.cell = (row["cell"] as? String)!
                self.leftmsg = (row["leftmsg"] as? Int)!
                self.notfiy = (row["notify"] as? Int)!
//                    
//                self.address = (row["address"] as? String)!
//        
//                self.city = (row["city"] as? String)!
//                self.state = (row["state"] as? String)!
//                self.zip = (row["zip"] as? String)!
//                self.website = (row["website"] as? String)!
//                self.company = (row["company"] as? String)!
                }
                
            //}
        
        } catch (let err as NSError) {
            user_id = 0
            print(err.debugDescription)
        }
        closedb()
        return user_id != 0
    }
    
    func save() -> Bool {
        do {
            
            let usersmt = try conn.prepare("SELECT * FROM users WHERE email=?")
            
            let res = try usersmt.query([self.email])
            
            if  let _ = try res.readRow() {
                return false
            }
        } catch {
               let urlstr  = "\(REF_ADDUSER_URL)email=\(self.email)&passwd=\(self.pass)"
            
            Alamofire.request(.GET, urlstr, parameters: ["fname": self.firstname,
                "lname": self.lastname,
                "phone": self.phone,
                "cell": self.cell,
                "address": self.address,
                "city": self.city,
                "state": self.state,
                "zip": self.zip,
                "website": self.website,
                "company": self.company,
                "leftmsg": self.leftmsg,
                "notify": self.notfiy])
            
        
        }
        
        
        return logon()
    }

    func updatecredits(credits:  Int) {
        
        logon()
        self.leftmsg = credits + self.leftmsg
        
        
        let urlstr  = "\(REF_UPDATECREDITS_URL)user_id=\(self.email)&pwd=\(self.pass)"
        
        Alamofire.request(.GET, urlstr, parameters: ["credits": self.leftmsg])
        
        
    }
 
 
 }
 
 
 
 
 
 
 
 