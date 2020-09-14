//
//  ingredientsTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/27/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class ingredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var txtnguyenlieu: UITextView!
    var rowindex : Int?
    var delegate : ParentControllerDelegate?
    
    @IBAction func deleterow(_ sender: Any) {
        if let deletekey = addingredientsViewController.nguyenlieu.firstIndex(where: {$0 == txtnguyenlieu.text}){
            addingredientsViewController.nguyenlieu.remove(at: deletekey)
        }
        delegate?.requestReloadTable()
    }
}
