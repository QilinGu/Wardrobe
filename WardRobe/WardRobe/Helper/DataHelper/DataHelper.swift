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

}