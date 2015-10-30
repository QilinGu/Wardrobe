//
//  DataHelper.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import Foundation
import CoreData
public class DataHelper: NSObject {
    public class var sharedInstance : DataHelper
    {
        struct Static {
            static let instance : DataHelper = DataHelper()
        }
        return Static.instance
    }

    public func fetchAllCategories()
    {
        var categoryList = [Category]()
        let fetchRequest = NSFetchRequest(entityName: "Category")
        do {
            try categoryList = DatabaseHelper.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        UserSession.sharedInstance.categoryList = categoryList
    }

    func fetchCategory(name : String) -> Category
    {
        var categoryList = [Category]()
        let fetchRequest = NSFetchRequest(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "categoryName == %@", name)
        do {
            try categoryList = DatabaseHelper.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
            if(categoryList.count > 0)
            {
                return categoryList[0]
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        return Category()
    }

    func deleteItem(name : String)
    {
        var itemList = [Item]()

        let fetchRequest = NSFetchRequest(entityName: "Item")
        do {
            try itemList = DatabaseHelper.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Item]
            if(itemList.count > 0)
            {
                DatabaseHelper.sharedInstance.managedObjectContext.deleteObject(itemList[0] as Item)
            }
        } catch _ as NSError {
            // failure
        }
    }

    func editItem(name : String, updatedName : String, updatedImage : NSData)
    {
        var itemList = [Item]()

        let fetchRequest = NSFetchRequest(entityName: "Item")
        do {
            try itemList = DatabaseHelper.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Item]
            if(itemList.count > 0)
            {
                let item = (itemList[0] as Item)
                item.itemName = updatedName
                item.itemImage  = updatedImage
                do {
                    try DatabaseHelper.sharedInstance.managedObjectContext.save()

                } catch _ as NSError {
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

}