//
//  BuyVC.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/28/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class BuyVC: UIViewController, SKProductsRequestDelegate, UITableViewDelegate, UITableViewDataSource {

    
    var creditslist = [Credits]()
    
    @IBOutlet var tableview: UITableView!
    var products = [SKProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
      
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if  userdata.user_id == 0 {
            self.showerror("Login", message: "You must be logged in")
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        getcredits()
        getproductsfromapple()

    }
    
    func getproductsfromapple() {
        let ids: Set<String> = ["net.ourweb.smsrealtors1.sms1", "net.ourweb.smsrealtors1.sms2", "net.ourweb.smsrealtors1.sms3","net.ourweb.smsrealtors1.sms4"]
        
        let prodsrequest = SKProductsRequest(productIdentifiers: ids)
        prodsrequest.delegate = self
        prodsrequest.start()
        
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
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        
        
        print("Number of Products:  \(response.products.count)")
        
        products = response.products
        
        tableview.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCellWithIdentifier("productcell") as? productcell {
            cell.ConfigureCell(products[indexPath.row])
            return cell
        }  else {
            let  cell = productcell()
            cell.ConfigureCell(products[indexPath.row])
            return cell
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
