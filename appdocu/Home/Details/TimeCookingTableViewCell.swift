//
//  TimeCookingTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/4/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class TimeCookingTableViewCell: UITableViewCell {


    
    @IBOutlet weak var khauphan : UILabel!
    @IBOutlet weak var thoigiannau : UILabel!
    @IBOutlet weak var like: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
