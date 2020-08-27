//
//  PostrecipeTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/26/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class PostrecipeTableViewCell: UITableViewCell {

    static var txtname : String!
    @IBOutlet weak var name: UITextView!
    
    func truyen() {
        PostrecipeTableViewCell.txtname = name.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
