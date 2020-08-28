//
//  HomeDetailsCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/24/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class HomeDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageview : UIImageView!
    func truyenvecolletion(image : String) {
        imageview.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
    }

}
