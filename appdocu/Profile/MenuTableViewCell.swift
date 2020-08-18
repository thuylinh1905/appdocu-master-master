//
//  MenuTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/10/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var tt: UILabel!
    
    func truyenve(menu : MenuModel) {
        tt.text = menu.menuname
    }
    
}
