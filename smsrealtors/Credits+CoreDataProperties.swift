//
//  Credits+CoreDataProperties.swift
//  
//
//  Created by Bill Banks on 4/27/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Credits {

    @NSManaged var title: String?
    @NSManaged var product_id: String?
    @NSManaged var credits: NSNumber?

}
