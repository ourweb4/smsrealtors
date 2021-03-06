//
//  ViewController.swift
//  smsrealtors
//
//  Created by Bill Banks on 2/22/16.
//  Update on 4/27/16
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit
import CoreData

//import MySqlSwiftNative

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var userdata: user!
    
    var memberlist = [members]()
    var creditslist = [Credits]()

    
    @IBOutlet var versoinTXT: UILabel!
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var messagestxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        getcredits()
        
        if creditslist.count == 0 {
            createCredits("1,000 SMS Credits", product_id: "net.ourweb.smsrealtors1.sms1", credits: 1000)
            createCredits("5,000 SMS Credits", product_id: "net.ourweb.smsrealtors1.sms2", credits: 5000)
            createCredits("10,000 SMS Credits", product_id: "net.ourweb.smsrealtors1.sms3", credits: 10000)
            createCredits("25,000 SMS Credits", product_id: "net.ourweb.smsrealtors1.sms4", credits: 25000)
            getcredits()
        }
        
  

    
    }
    
    func createCredits(title: String, product_id: String, credits: Int) {
        let appdel = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context = appdel.managedObjectContext
        
        if let rec = NSEntityDescription.entityForName("Credits", inManagedObjectContext: context) {
            let ins = NSManagedObject(entity: rec, insertIntoManagedObjectContext: context) as! Credits
            ins.title = title
            ins.product_id = product_id
            ins.credits =  credits
            
        }
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func getcredits() {
        
        let appdel = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context = appdel.managedObjectContext
        let fetch = NSFetchRequest(entityName: "Credits")
        
        do {
            let credits_arr = try context.executeFetchRequest(fetch)
            creditslist = credits_arr as! [Credits]
        } catch {}
        
        
        
    }
    
    func loadmembers() {
      let user_id = userdata.user_id
        if user_id != 0 {
            memberlist.removeAll()
            opendb()
            do {
                let table = MySQL.Table(tableName:"members", connection:conn)
                // select all rows from the table given a condition
                
                let resultSets = try table.select(Where: ["user_id=",user_id])
                
                if resultSets?.count > 0 {
                    let rows = resultSets![0]
                    
                    for row in rows {
                        
                        let member_id = (row["member_id"] as! UInt)
                        
                        let optin = (row["optin"] as? Int)!
                        let name = (row["name"] as? String)!
                        let cell = (row["cell"] as? String)!
                        
                        let addmember = members(member_id: member_id, user_id: user_id, name: name, cell: cell, opin:optin)
                        
                        memberlist.append(addmember)

                    }
                }
                
            } catch (let err as NSError) {
               print(err.debugDescription)
        
            }
            closedb()
            tableview.reloadData()
        }
    
    }
    
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberlist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCellWithIdentifier("membercell") as? membercell {
            cell.ConfigureCell(memberlist[indexPath.row])
            return cell
        }  else {
          let  cell = membercell()
         cell.ConfigureCell(memberlist[indexPath.row])
          return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         askit("Delete", message: "Are you sure?", member: memberlist[indexPath.row])
            
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        let version: String = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        self.versoinTXT.text = "Ver \(version)"
        self.messagestxt.text = ""
        
        if let email = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String {
            if let pwd = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String {
                userdata.email = email
                userdata.pass = pwd
                if userdata.logon() {
                  self.messagestxt.text = "Message Left: \(userdata.leftmsg)"
                }
                
            }
        }
        
        loadmembers()
    }

    @IBAction func loginclick(sender: AnyObject) {
             performSegueWithIdentifier("loadlogon", sender: nil)
    }
    
    func showerror(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,  handler: nil )
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion:  nil)
    }
   
    func askit(title: String, message: String, member: members) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let yes = UIAlertAction(title: "Yes", style: .Default, handler: { action in
            member.delete()
            self.loadmembers()
            
        }
        )
        let no = UIAlertAction(title: "No", style: .Default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }


}

