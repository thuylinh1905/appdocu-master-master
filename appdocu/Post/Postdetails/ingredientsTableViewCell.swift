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
        addingredientsViewController.nguyenlieu.remove(at: rowindex ?? 0)
        delegate?.requestReloadTable()
    }
}

extension ingredientsTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString
        let proposedText = currentText.replacingCharacters(in: range, with: text)
        addingredientsViewController.nguyenlieu[rowindex ?? 0] = String(proposedText)
        return true
    }
}
