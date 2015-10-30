//
//  AddItemViewController.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var itemLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var contentBackgroundView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameTextField: UITextField!
    var categoryName : String?
    var selectedColor : UIColor?
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.categoryName!.uppercaseString
        self.contentBackgroundView.layer.cornerRadius = kAddBackgroundCornerRadius
        self.addItemButton.layer.cornerRadius = kAddButtonCornerRadius

        self.addItemButton.backgroundColor = self.selectedColor!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)

        self.itemLabelHeight.constant = txtAfterUpdate.length > 0 ? kTextFieldDefaultHeight : kTextFieldCompressedHeight

        return true
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        self.view.endEditing(true)

        super.touchesBegan(touches, withEvent:event)
    }

}
