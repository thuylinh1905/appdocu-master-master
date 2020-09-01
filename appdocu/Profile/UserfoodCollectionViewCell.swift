//
//  UserfoodCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/1/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class UserfoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func truyenanh(imagestring : String){
        image.sd_setImage(with: URL(string: imagestring), placeholderImage: UIImage(named: "placeholder"))
    }
}
