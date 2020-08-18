//
//  HomeNewFeedCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/11/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import Kingfisher

class HomeNewFeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var blackLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    func truyenve(truyenim : String) {
        image.sd_setImage(with: URL(string: truyenim),placeholderImage: UIImage(named: "placeholder.png"))
    }
}
