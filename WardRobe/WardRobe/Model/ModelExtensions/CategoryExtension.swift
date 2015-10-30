//
//  CategoryExtension.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import Foundation
import CoreData
extension Category {

    class func createCategory(name: String, image : NSData) {
        let category : Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: DatabaseHelper.sharedInstance.managedObjectContext) as! Category
        category.categoryName = name
        category.categoryImage = image
        DatabaseHelper.sharedInstance.saveContext()
    }
}