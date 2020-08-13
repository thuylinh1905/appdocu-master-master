//
//  InputView.swift
//  Gallery
//
//  Created by Cata on 7/8/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    @IBAction func hide(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

    }
    



}
