//
//  CronsVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/7/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit

class CronsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var cronslist = [crons]()
    
    
    @IBOutlet var tableview: UITableView!
    
    func loadcrons() {
        
        let user_id = userdata.user_id
        if user_id != 0 {
             cronslist.removeAll()
            opendb()
            do {
                let table = MySQL.Table(tableName:"crons", connection:conn)
                // select all rows from the table given a condition
                
                let resultSets = try table.select(Where: ["user_id=",user_id])
                
                if resultSets?.count > 0 {
                    let rows = resultSets![0]
                    
                    for row in rows {
                       // print(row["crons_id"])
                        let crons_id = (row["crons_id"] as! Int)
                        let date = (row["date"] as? NSDate)!
                        let text = (row["text"] as? String)!
                        let totype = (row["totype"] as? String)!
                        let time = (row["time"] as? Int)!
                        let title = (row["title"])!
                        
                        let hour = (row["hour"] as? Int)!
                       //let monthly = (row["monthly"] as? Int)!
                        
                        
                        
                        let addcrons = crons(crons_id: crons_id, user_id: user_id, date: date, text: text, totype: totype, time:
                            "\(time)", title: "\(title)", hour: "\(hour)", monthly: "")
                        
                        cronslist.append(addcrons)
                        
                    }
                }
                
            } catch (let err as NSError) {
                print(err.debugDescription)
                
            }
            closedb()
            tableview.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        if let cell = tableview.dequeueReusableCellWithIdentifier("croncell") as? croncell {
            cell.ConfigureCell(cronslist[indexPath.row])
            return cell
        }  else {
            let  cell = croncell()
            cell.ConfigureCell(cronslist[indexPath.row])
            return cell
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        
    }
    
    override func viewDidAppear(animated: Bool) {
        loadcrons()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cronslist.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        askit("Delete", message: "Are you sure?", cron: cronslist[indexPath.row])
        loadcrons()
    }
    
    
    
    func showerror(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,  handler: nil )
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion:  nil)
    }
    
    func askit(title: String, message: String, cron: crons) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let yes = UIAlertAction(title: "Yes", style: .Default, handler: { action in
            cron.delete()
            
            
            }
        )
        let no = UIAlertAction(title: "No", style: .Default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    
    
    
    
}
