//
//  ItemHeaderView.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

class ItemHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headerTitleLabel.textColor = UIColor.getHeaderTitleColor()     
    }
    
}
