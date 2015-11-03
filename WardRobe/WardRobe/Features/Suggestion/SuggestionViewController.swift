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
    @IBOutlet weak var item2ImageView: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get suggestion for shirts
        let category1 : Category = UserSession.sharedInstance.categoryList[0]
        let lowerItem1 : Int = 0
        let upperItem1 : Int = category1.category_item!.allObjects.count - 1
        let randomItem1 : Int = Int(arc4random_uniform(UInt32(upperItem1 - lowerItem1))) + lowerItem1

        //Get suggestion for pants
        let category2 : Category = UserSession.sharedInstance.categoryList[1]
        let lowerItem2 : Int = 0
        let upperItem2 : Int = category2.category_item!.allObjects.count - 1
        let randomItem2 : Int = Int(arc4random_uniform(UInt32(upperItem2 - lowerItem2))) + lowerItem2

        self.navigationView.backgroundColor = UIColor.navigationBarColor()  
        self.item1ImageView.clipsToBounds = true
        self.item2ImageView.clipsToBounds = true

        self.item1ImageView.layer.borderColor = UIColor.navigationBarColor().CGColor
        self.item1ImageView.layer.borderWidth = 1
        self.item1ImageView.layer.cornerRadius = 10

        self.item2ImageView.layer.borderColor = UIColor.navigationBarColor().CGColor
        self.item2ImageView.layer.borderWidth = 1
        self.item2ImageView.layer.cornerRadius = 10

        self.item1ImageView.image = UIImage(data: (category1.category_item!.allObjects[randomItem1] as! Item).itemImage!)
        self.item2ImageView.image = UIImage(data: (category2.category_item!.allObjects[randomItem2] as! Item).itemImage!)
    }

    override func viewDidAppear(animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)   
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
