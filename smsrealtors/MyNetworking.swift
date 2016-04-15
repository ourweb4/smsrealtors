//
//  MyNetworking.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/6/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import Foundation
class MyNetworking {
    
    var urlstr: String!
    var nsurl: NSURL!
    var json: AnyObject?
    var dict : Dictionary<String, AnyObject>?
    
    var error: NSError?
    
    
    let session = NSURLSession.sharedSession()
    
    init(url: String) {
        self.urlstr = url
        
        self.nsurl = NSURL(string: self.urlstr)
        
        self.runurl()
    }
    
    func runurl() {
        self.session.dataTaskWithURL(self.nsurl) { (data: NSData?, response:NSURLResponse?, error: NSError?) in
            
             self.error = error
            
            if let rdata = data {
                
                do {
                    
                    let tjson = try NSJSONSerialization.JSONObjectWithData(rdata, options: .AllowFragments)
                    
                    self.json = tjson
                    
                    self.dict = tjson as? Dictionary<String, AnyObject>
                    
                } catch {
                    self.json = nil
                }
            }
        }.resume()
    }
    
    
}