//
//  SuggestionViewController.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/31/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    @IBOutlet weak var item1ImageView: UIImageView!
    @IBOutlet weak var item1View: UIView!
    @IBOutlet weak var item2View: UIView!
    @IBOutlet weak var category1DynamicConstraint: NSLayoutConstraint!
    @IBOutlet weak var item2ImageView: UIImageView!
    @IBOutlet weak var category2DynamicConstraint: NSLayoutConstraint!
    @IBOutlet weak var category1ImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let category1 : Category = UserSession.sharedInstance.categoryList[0]
        let lowerItem1 : Int = 0
        let upperItem1 : Int = category1.category_item!.allObjects.count - 1
        let randomItem1 : Int = Int(arc4random_uniform(UInt32(upperItem1 - lowerItem1))) + lowerItem1

        let category2 : Category = UserSession.sharedInstance.categoryList[1]
        let lowerItem2 : Int = 0
        let upperItem2 : Int = category2.category_item!.allObjects.count - 1
        let randomItem2 : Int = Int(arc4random_uniform(UInt32(upperItem2 - lowerItem2))) + lowerItem2

        self.item1ImageView.image = UIImage(data: (category1.category_item!.allObjects[randomItem1] as! Item).itemImage!)

        self.item2ImageView.image = UIImage(data: (category2.category_item!.allObjects[randomItem2] as! Item).itemImage!)


    }

    override func viewDidAppear(animated: Bool) {
        self.category1DynamicConstraint.constant = -450
        self.category2DynamicConstraint.constant = 450

        UIView.animateWithDuration(2) {
        self.category1DynamicConstraint.constant = -100
        self.category2DynamicConstraint.constant = 100

        self.item1View.layoutIfNeeded()
        self.item2View.layoutIfNeeded()

        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
