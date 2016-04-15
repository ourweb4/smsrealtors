//
//  My_members+CoreDataProperties.swift
//  smsrealtors
//
//  Created by Bill Banks on 2/26/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension My_members {

    @NSManaged var member_id: NSNumber?
    @NSManaged var user_id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var cell: String?
    @NSManaged var opin: NSNumber?

}
