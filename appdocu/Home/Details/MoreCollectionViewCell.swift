//
//  MoreCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/4/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class MoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
