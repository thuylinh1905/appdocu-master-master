//
//  ProfileOtherUserTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/10/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileOtherUserTableViewCell: UITableViewCell {

    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var motacongthuc: UILabel!
    @IBOutlet weak var anh: UIImageView!
    @IBOutlet weak var view: UIView!
    func truyenve(newfeed : NewFeedmodel1) {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.2
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tencongthuc.text = newfeed.tencongthuc
        motacongthuc.text = newfeed.motacongthuc
        let first = newfeed.image.prefix(1)
        for i in first {
            anh.sd_setImage(with: URL(string: i))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
