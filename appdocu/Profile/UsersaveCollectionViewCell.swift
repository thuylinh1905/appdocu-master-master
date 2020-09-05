//
//  UsersaveCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/5/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class UsersaveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var user: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tencongthuc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func truyenve(usersave : UserSave) {
        tencongthuc.text = usersave.tencongthuc
        username.text = usersave.username
        user.sd_setImage(with: URL(string: usersave.imageprofile))
        let first5 = usersave.image.prefix(1)
        for i in first5 {
            image.sd_setImage(with: URL(string: i))
        }
    }

}
