//
//  CookingTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/27/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class CookingTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var txtcongthuc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func truyen(nb : Int){
        number.text = String(nb)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleterow(_ sender: Any) {
    }
}
