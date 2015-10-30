//
//  DashboardViewController.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

public class DashboardViewController: UIViewController {
    let backgroundColors = [UIColor.getBlueBackgroundForShirt(), UIColor.getCremeBackgroundForShirt()]
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCategory : Category?
    var selectedColor : UIColor?
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNib(UINib(nibName: kRowCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kRowCellIdentifier)
        self.collectionView.registerNib(UINib(nibName: kHeaderCellIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderCellIdentifier)
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Roboto-Light", size: 18)!]

        self.title = kDashboardTitle
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as! AddItemViewController
        destinationViewController.itemDelegate  = self
        destinationViewController.categoryName = self.selectedCategory!.categoryName!
        destinationViewController.selectedColor = self.selectedColor!
    }


}

extension DashboardViewController : UICollectionViewDataSource {

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if(collectionView == self.collectionView)
        {
            return UserSession.sharedInstance.categoryList.count
        }
        return 1
    }


    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(collectionView == self.collectionView)
        {
            return 1
        }
        let category : Category = UserSession.sharedInstance.categoryList[collectionView.tag]
        return category.category_item!.count + 1
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(collectionView == self.collectionView)
        {
            let cell : ItemRowCell = collectionView.dequeueReusableCellWithReuseIdentifier(kRowCellIdentifier, forIndexPath: indexPath) as! ItemRowCell
            cell.collectionView.backgroundColor = self.backgroundColors[indexPath.section]
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.tag = indexPath.section
            cell.collectionView.reloadData()
            return cell
        }
        let cell : ItemGridCell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemGridCell", forIndexPath: indexPath) as! ItemGridCell
        let category : Category = UserSession.sharedInstance.categoryList[collectionView.tag]
        if(indexPath.item == category.category_item!.count)
        {
            cell.itemimageView.image = UIImage(named: kDefaultImage)
        }
        else
        {
            cell.itemimageView.image = UIImage(data: (category.category_item?.allObjects[indexPath.row] as! Item).itemImage!)
            cell.itemNameLabel.text = (category.category_item?.allObjects[indexPath.row] as! Item).itemName
        }
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.cornerRadius = 5.0

        return cell
    }

    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if(collectionView == self.collectionView)
        {
            let headerView: ItemHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderCellIdentifier, forIndexPath:   indexPath) as! ItemHeaderView
            let category : Category = UserSession.sharedInstance.categoryList[indexPath.section]
            headerView.headerTitleLabel.text = category.categoryName?.uppercaseString
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension DashboardViewController : UICollectionViewDelegate{
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(collectionView != self.collectionView)
        {
            self.selectedCategory =  UserSession.sharedInstance.categoryList[indexPath.section]
            self.selectedColor = self.backgroundColors[collectionView.tag]
            self.performSegueWithIdentifier(kAddItemSegue, sender: self)
        }
    }
}

extension DashboardViewController : UICollectionViewDelegateFlowLayout{
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if(collectionView == self.collectionView)
        {
            return CGSizeMake(self.collectionView.frame.size.width, kDefaultRowHeight)
        }
        return CGSizeMake((self.collectionView.frame.size.width - (4 * kEdgeInsetLevel2Collection)) / kMaxCellsPerRow, kDefaultRowHeight - (kEdgeInsetLevel2Collection * 2))
    }

    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kDefaultInterItemSpacing
    }

    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if(collectionView == self.collectionView)
        {
            return UIEdgeInsetsZero
        }
        return UIEdgeInsetsMake(kEdgeInsetLevel2Collection, kEdgeInsetLevel2Collection, kEdgeInsetLevel2Collection, kEdgeInsetLevel2Collection)
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(collectionView == self.collectionView)
        {
            return CGSizeMake(collectionView.frame.size.width, kDefaultHeaderHeight)
        }
         return CGSizeZero
    }
}

extension DashboardViewController : AddItemDelegate{
    func itemAdded()
    {
        DataHelper.sharedInstance.fetchAllCategories()
        self.collectionView.reloadData()    
    }
}