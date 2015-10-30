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
const CGFloat kAddBackgroundCornerRadius  = 10.0;
const CGFloat kEdgeInsetLevel2Collection = 10;
const CGFloat kMaxCellsPerRow = 3;
const CGFloat kDefaultRowHeight = 150;
const CGFloat kDefaultInterItemSpacing = 0.0;
const CGFloat kDefaultHeaderHeight = 30;


//Add Item

const NSString *kAddItemSegue = @"AddItemSegue";

//Cells

const NSString *kHeaderCellIdentifier = @"ItemHeaderView";
const NSString *kRowCellIdentifier = @"ItemRowCell";

//Images

//Need to change
const NSString *kDefaultImage = @"add";

//Dashboard

const NSString *kDashboardTitle = @"MY WARDROBE";

#endif /* Constants_h */
