//
//  LaucherViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/13/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class LaucherViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var stackview: UIStackView!
    var effect:UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.buttonchangehome(button: button)
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.0, options: [], animations: {
            self.background.alpha = 0.3
        }, completion: nil)
        UIView.animate(withDuration: 1.5, animations: {
            self.button.alpha = 1.0
            self.button.center.y -= 100
            self.stackview.alpha = 1.0
            self.stackview.center.y -= 100
        }, completion: nil)
    }

    @IBAction func signin(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoSignin()
    }
    @IBAction func signup(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoSignup()
    }
}
