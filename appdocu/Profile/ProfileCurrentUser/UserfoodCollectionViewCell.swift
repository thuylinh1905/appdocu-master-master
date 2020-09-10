//
//  UserfoodCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/9/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class UserfoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var view: UIView!
    var newFeed: NewFeedmodel1!
    
    func truyen(Newfeed : NewFeedmodel1) {
        let key = Newfeed.keyid
        self.newFeed = Newfeed
        username.text = Newfeed.username
        text.text = Newfeed.tencongthuc
        imageuser.sd_setImage(with: URL(string: Newfeed.imageprofile))
        imageuser.layer.cornerRadius = 10
        let first5 = Newfeed.image.prefix(1)
        for i in first5 {
            image.sd_setImage(with: URL(string: i))
        }
    }
    
    @IBAction func more(_ sender: Any) {
        print("đính")
    }
}
