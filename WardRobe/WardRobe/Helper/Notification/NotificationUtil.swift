//
//  NotificationUtil.swift
//  WardRobe
//
//  Created by Vinita Miranda on 11/1/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import Foundation
import UIKit
public class NotificationUtil{

    /*
    Checks if notification was set
    */
    class public func isNotificationSet() -> Bool{
        let notifications : [UILocalNotification] = UIApplication.sharedApplication().scheduledLocalNotifications!
        return notifications.count > 0
    }

    /*
    Cancels all previously set notification
    */
    class public func cancelAllNotification(){
        let notifications : [UILocalNotification] = UIApplication.sharedApplication().scheduledLocalNotifications!
        for notification in notifications {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
    }

    /*
    Sets the default notification
    */
    class public func setNotification(){
        if(!NotificationUtil.isNotificationSet())
        {
            let date = NSDate()
            let calendar : NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let calendarComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month , NSCalendarUnit.Year], fromDate: date)
            let nextDate : NSDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: date, options: NSCalendarOptions.WrapComponents)!
            let nextDateCalendarComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month , NSCalendarUnit.Year], fromDate: nextDate)

            calendarComponents.hour = Int(kNotificationHours)
            calendarComponents.second = 0
            calendarComponents.minute = 0
            calendarComponents.day = nextDateCalendarComponents.day
            calendar.timeZone = NSTimeZone.defaultTimeZone()
            let dateToFire = calendar.dateFromComponents(calendarComponents)

            let notification = UILocalNotification()
            notification.alertBody = "Today's suggesstion"
            notification.alertAction = "Open"
            notification.fireDate = dateToFire
            notification.repeatInterval = NSCalendarUnit.Day
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }

}