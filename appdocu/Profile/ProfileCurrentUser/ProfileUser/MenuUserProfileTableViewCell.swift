//
//  MenuUserProfileTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/21/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class MenuUserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var txtthonfbao: UILabel!
    @IBOutlet weak var imagesetting : UIImageView!
    
    func truyenve(menuSetting : MenuSetting) {
        txtthonfbao.text = menuSetting.name
        imagesetting.image = menuSetting.image
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
}
