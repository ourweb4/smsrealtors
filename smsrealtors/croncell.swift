//
//  croncell.swift
//  smsrealtors
//
//  Created by Bill Banks on 4/8/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit

class croncell: UITableViewCell {

    @IBOutlet var dateTXT: UILabel!
    @IBOutlet var titleTXT: UILabel!
    @IBOutlet var timeTXT: UILabel!
    @IBOutlet var textTXT: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func ConfigureCell(cdata: crons) {
        
        titleTXT.text = cdata.title
        textTXT.text = cdata.text
        dateTXT.text = cdata.date.dateString()
        
        if cdata.time == "0" {
            timeTXT.text = "Once"
        }
        
        if cdata.time == "1" {
            timeTXT.text = "Daily"
        }
        if cdata.time == "7" {
            timeTXT.text = "Weekly"
        }
        if cdata.time == "30" {
            timeTXT.text = "Monthly"
        }
        if cdata.time == "365" {
            timeTXT.text = "Yearly"
        }
        
    }
    
}
