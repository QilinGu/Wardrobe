//
//  UserSession.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import Foundation


public class UserSession: NSObject {
    var categoryList = [Category]()

    public class var sharedInstance : UserSession
    {
        struct Static {
            static let instance : UserSession = UserSession()
        }
        return Static.instance
    }
}