//
//  SearchTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/6/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var motacongthuc: UILabel!
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var view: UIView!
    var celldetails : NewFeedmodel1!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func truyenve(newfeed : NewFeedmodel1) {
        self.celldetails = newfeed
        imageuser.layer.cornerRadius = imageuser.frame.size.width / 2
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.2
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tencongthuc.text = newfeed.tencongthuc
        motacongthuc.text = newfeed.motacongthuc
        username.text = newfeed.username
        imageuser.sd_setImage(with: URL(string: newfeed.imageprofile))
        let first1 = newfeed.image.prefix(1)
        for i in first1 {
            images.sd_setImage(with: URL(string: i))
        }
    }
}
