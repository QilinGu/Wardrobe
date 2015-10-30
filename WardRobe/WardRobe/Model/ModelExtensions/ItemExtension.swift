//
//  ItemExtension.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import Foundation
import CoreData
extension Item {

    class func createItem(itemName: String, image : NSData, categoryName : String) {
        let item : Item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: DatabaseHelper.sharedInstance.managedObjectContext) as! Item
        item.itemName = itemName
        item.itemImage = image

        let category : Category =  DataHelper.sharedInstance.fetchCategory(categoryName)
        item.item_category = category
        category.category_item?.setByAddingObject(item)
        DatabaseHelper.sharedInstance.saveContext()
    }


}