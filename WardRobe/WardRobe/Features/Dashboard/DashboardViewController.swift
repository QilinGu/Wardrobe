//
//  DashboardViewController.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

public class DashboardViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.registerNib(UINib(nibName: kRowCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kRowCellIdentifier)
        self.collectionView.registerNib(UINib(nibName: kHeaderCellIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderCellIdentifier)
        self.collectionView.registerNib(UINib(nibName: kHeaderCellIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: kHeaderCellIdentifier)

        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Roboto-Light", size: 18)!]
        self.navigationController!.navigationBar.barTintColor = UIColor.navigationBarColor()

        self.title = kDashboardTitle
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

    func deleteButtonClicked(button : UIButton)
    {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this item?", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        let defaultAction = UIAlertAction(title: "Yes", style: .Default, handler: { action in
            let position: CGPoint = button.convertPoint(CGPointZero, toView: self.collectionView)
            if let indexPath = self.collectionView.indexPathForItemAtPoint(position)
            {
                let section = indexPath.section
                let category : Category = UserSession.sharedInstance.categoryList[section]
                let item = (category.category_item?.allObjects[button.tag] as! Item)
                DataHelper.sharedInstance.deleteItem(item.itemName!)
                self.itemAdded()
            }


        })
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
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
            cell.deleteButton.hidden = true
        }
        else
        {
            cell.deleteButton.hidden = false
            cell.itemimageView.image = UIImage(data: (category.category_item?.allObjects[indexPath.row] as! Item).itemImage!)
            cell.itemNameLabel.text = (category.category_item?.allObjects[indexPath.row] as! Item).itemName
        }
        cell.deleteButton.addTarget(self, action: "deleteButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.deleteButton.tag = indexPath.item
        cell.contentView.clipsToBounds = true
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
            let category : Category = UserSession.sharedInstance.categoryList[collectionView.tag]
            let addItemVC : AddItemViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddItemViewController") as! AddItemViewController
            addItemVC.categoryName = UserSession.sharedInstance.categoryList[collectionView.tag].categoryName!
            addItemVC.itemDelegate  = self
            if(indexPath.item == category.category_item!.count)
            {
                addItemVC.actionType = ActionType.AddNew
            }
            else
            {
                addItemVC.editingItem = (category.category_item?.allObjects[indexPath.row] as! Item)
                addItemVC.actionType = ActionType.EditItem
            }
            self.presentViewController(addItemVC, animated: true, completion: nil)
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


    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if(collectionView == self.collectionView)
        {
            return 0
        }
        return kEdgeInsetLevel2Collection
    }
}

extension DashboardViewController : AddItemDelegate{
    func itemAdded()
    {
        DataHelper.sharedInstance.fetchAllCategories()
        self.collectionView.reloadData()    
    }
}