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
    @IBOutlet weak var txtcongthuc: UITextView!
    var rowindex : Int?
    var delegate : ParentControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func truyen(nb : Int){
        number.text = String(nb)
    }
    @IBAction func deleterow(_ sender: Any) {
        addingredientsViewController.congthuc.remove(at: rowindex ?? 0)
        delegate?.requestReloadTable()
    }
    
}
extension CookingTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString
        let proposedText = currentText.replacingCharacters(in: range, with: text)
        addingredientsViewController.congthuc[rowindex ?? 0] = String(proposedText)
        return true
    }
}
