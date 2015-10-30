//
//  ItemRowCell.swift
//  WardRobe
//
//  Created by Vinita Miranda on 10/29/15.
//  Copyright © 2015 bombaybrew. All rights reserved.
//

import UIKit

class ItemRowCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerNib(UINib(nibName: "ItemGridCell", bundle: nil), forCellWithReuseIdentifier: "ItemGridCell")
    }

}
