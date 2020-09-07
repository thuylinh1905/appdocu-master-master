//
//  MenuCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/6/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    var cellmenu : MenuFood!
    func truyenve(menufood : MenuFood) {
        self.cellmenu = menufood
        image.sd_setImage(with: URL(string: menufood.image))
        name.text = menufood.name
        image.layer.cornerRadius = 10
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
