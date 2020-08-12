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
    
    @IBOutlet weak var image: UIImageView!
    func truyenve(truyenim : String) {
        print("đay la truyen image/\(truyenim)")
        image.sd_setImage(with: URL(string: truyenim),placeholderImage: UIImage(named: "placeholder.png"))
    }
}
