//
//  ItemGridCell.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

class ItemGridCell: UICollectionViewCell {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var itemNameView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemimageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.borderView.layer.borderColor = UIColor.navigationBarColor().CGColor
        self.borderView.layer.borderWidth = 1
        self.borderView.layer.cornerRadius = 5
    }

}
