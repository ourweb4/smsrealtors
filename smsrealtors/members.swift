//
//  members.swift
//  smsrealtors
//
//  Created by Bill Banks on 2/26/16.
//  Update on 3/30/16
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import Foundation
import Alamofire

//import MySqlSwiftNative

class members {
    
    var member_id: UInt!
    var user_id: UInt!
    var name: String!
    var cell: String!
    var opin: Int!
    
    init(member_id: UInt, user_id: UInt, name: String, cell: String, opin: Int) {
        self.member_id = member_id
        self.user_id = user_id
        self.name = name
        self.cell = cell
        self.opin = opin
        
    }
    
    func load() {
        opendb()
        do {
            let select_stmt = try conn.prepare("SELECT * FROM members WHERE member_id=?")
            let res =  try select_stmt.query([member_id])
            let row = try res.readRow()
            
            self.user_id = (row!["user_id"] as? UInt)
            self.opin = (row!["optin"] as? Int)
            self.name = (row!["name"] as? String)
            self.cell = (row!["cell"] as? String)
        
        } catch (let err as NSError) {
            print(err.debugDescription)
        }
        closedb()
        
    }
    
    func save(usr: user) {
        if let pwd = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String {
            if self.user_id != 0 {
                let urlstr = "\(REF_ADDMEMBER_URL)user_id=\(self.user_id)&pwd=\(pwd)"
//                let url = NSURL(string: urlstr)
                print(urlstr)
                Alamofire.request(.GET, urlstr, parameters: ["name": name,
                                                             "cell": cell])
                
                

                
            }
        }
        
    }
   
    
    func delete() {
        if let pwd = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String {
            if self.user_id != 0 {
                let urlstr = "\(REF_DELMEMBER_URL)user_id=\(self.user_id)&pwd=\(pwd)&member_id=\(self.member_id)"
                //                let url = NSURL(string: urlstr)
                Alamofire.request(.GET, urlstr)
                
                
                
                
            }
        }
    }
    
}