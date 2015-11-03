//
//  Constants.h
//  WardRobe
//
//  Created by Vinita Miranda on 10/30/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Constants_h
#define Constants_h
const CGFloat kTextFieldDefaultHeight = 21.0;
const CGFloat kTextFieldCompressedHeight = 0.0;

const CGFloat kAddButtonCornerRadius = 5.0;
const CGFloat kEdgeInsetLevel2Collection = 10;
const CGFloat kMaxCellsPerRow = 3;
const CGFloat kDefaultRowHeight = 150;
const CGFloat kDefaultInterItemSpacing = 0.0;
const CGFloat kDefaultHeaderHeight = 30;

//Notification

const NSString *kNotificationSegue = @"showSuggestion";
const int kNotificationHours = 8;

//Text

const NSString *kEditItemText = @"UPDATE ITEM";
const NSString *kIncompleteErrorText = @"Please enter complete details to proceed";
const NSString *kIncompleteDismissText = @"OK";
const NSString *kDeleteErrorText = @"Are you sure you want to delete this item?";
const NSString *kDeleteDissmissText = @"No";
const NSString *kDeleteConfirmText = @"Yes";


//Cells

const NSString *kHeaderCellIdentifier = @"ItemHeaderView";
const NSString *kRowCellIdentifier = @"ItemRowCell";

//Images

//Need to change
const NSString *kDefaultImage = @"add";
const NSString *kShirtImage = @"Shirt";
const NSString *kPantImage = @"Pant";

//Dashboard

const NSString *kDashboardTitle = @"MY WARDROBE";

#endif /* Constants_h */
