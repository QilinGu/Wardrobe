//
//  AddItemViewController.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol AddItemDelegate{
    func itemAdded()
}

enum ActionType{
    case AddNew
    case EditItem
}

class AddItemViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var navigationView: UIView!
    var actionType : ActionType = ActionType.AddNew
    @IBOutlet weak var itemLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameTextField: UITextField!
    var categoryName : String?
    var editingItem : Item?
    var newMedia: Bool = false
    @IBOutlet weak var titleLabel: UILabel!
    var itemDelegate : AddItemDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        //Customization
        self.addItemButton.layer.cornerRadius = kAddButtonCornerRadius
        self.addItemButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.addItemButton.layer.borderWidth = 0.5
        self.navigationView.backgroundColor = UIColor.navigationBarColor()

        if(self.categoryName == kShirtImage)
        {
            self.itemImageView.image = UIImage(named: "shirt")
        }
        else
        {
            self.itemImageView.image = UIImage(named: "pant")
        }

        self.titleLabel.text = self.categoryName!.uppercaseString

        if(self.actionType == ActionType.EditItem)
        {
            //In cae of edit update data of label
            self.itemImageView.image = UIImage(data: self.editingItem!.itemImage!)
            self.itemNameTextField.text = self.editingItem!.itemName
            self.newMedia = true
            self.addItemButton.setTitle(kEditItemText, forState: UIControlState.Normal)
            self.addItemButton.setTitle(kEditItemText, forState: UIControlState.Selected)
        }

        self.itemImageView.layer.borderColor = UIColor.navigationBarColor().CGColor
        self.itemImageView.layer.borderWidth = 1
        self.itemImageView.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickPhoto(sender: AnyObject) {
//        if UIImagePickerController.isSourceTypeAvailable(
//            UIImagePickerControllerSourceType.Camera) {

                let imagePicker = UIImagePickerController()

                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.SavedPhotosAlbum
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false

                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
                newMedia = true
//        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        self.dismissViewControllerAnimated(true, completion: nil)
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            itemImageView.image = image
            self.changeAddButtonState()
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }

    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {

        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)

            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }

    @IBAction func dismissButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //Get text field text
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)

        //Unhide the label
        self.itemLabelHeight.constant = txtAfterUpdate.length > 0 ? kTextFieldDefaultHeight : kTextFieldCompressedHeight

        self.changeAddButtonState()

        return true
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        self.view.endEditing(true)

        super.touchesBegan(touches, withEvent:event)
    }

    @IBAction func addItemClicked(sender: AnyObject) {
        //Adding a new item
        if((self.itemNameTextField.text!.characters.count != 0) && newMedia && self.actionType == ActionType.AddNew)
        {
            Item.createItem(self.itemNameTextField.text!, image: UIImagePNGRepresentation(self.itemImageView.image!)!, categoryName: self.categoryName!)
            self.itemDelegate!.itemAdded()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else if((self.itemNameTextField.text!.characters.count != 0) && newMedia && self.actionType == ActionType.EditItem)
        {
            //Editing an existing item
            DataHelper.sharedInstance.editItem(self.editingItem!.itemName!, updatedName: self.itemNameTextField.text!, updatedImage: UIImagePNGRepresentation(self.itemImageView.image!)!)
            self.dismissViewControllerAnimated(true, completion: nil)
            self.itemDelegate!.itemAdded()

        }
        else
        {
            //error
            let alertController = UIAlertController(title: "", message: kIncompleteErrorText, preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: kIncompleteDismissText, style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }

    func changeAddButtonState()
    {
        if(self.newMedia && self.itemNameTextField.text?.characters.count > 0)
        {
            self.addItemButton.backgroundColor = UIColor.navigationBarColor()
        }
    }
}
