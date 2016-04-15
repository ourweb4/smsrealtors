//
//  membercell.swift
//  smsrealtors
//
//  Created by Bill Banks on 2/29/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import UIKit

class membercell: UITableViewCell {

    @IBOutlet var nameLB: UILabel!
    @IBOutlet var cellLB: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ConfigureCell(mdata: members) {
        
        if mdata.opin == 1 {
            self.nameLB.text = "*\(mdata.name!)"
        } else {
            self.nameLB.text = mdata.name!
        }
        self.cellLB.text = mdata.cell!
               
        
    }

}
