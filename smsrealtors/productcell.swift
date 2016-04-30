//
//  productcell.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/28/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit
import StoreKit

class productcell: UITableViewCell {
    
    
    @IBOutlet var titleLBL: UILabel!
    
    @IBOutlet var priceLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(title: String, price: String) {
        
        self.titleLBL.text = "\(title)"
        self.priceLBL.text = "\(price)"
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
