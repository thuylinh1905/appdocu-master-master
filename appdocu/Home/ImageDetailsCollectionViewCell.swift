//
//  ImageDetailsCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/18/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class ImageDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageview: UIImageView!
    func truyenve(imagecell : String) {
        imageview.sd_setImage(with: URL(string: imagecell), placeholderImage:  UIImage(named: "placeholder.png"))
    }
}
