//
//  LaucherAppViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/14/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class LaucherAppViewController: UIViewController {
    
    @IBOutlet weak var buttonsignup: UIButton!
    @IBOutlet weak var signin: UIStackView!
    @IBOutlet weak var viewload : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.changebutton(button: buttonsignup)
        self.hidenavi()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var image: UIImageView!
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5, animations: {
            self.image.alpha = 0.6
            self.viewload.center.y += 150
            self.buttonsignup.alpha = 1.0
            self.buttonsignup.center.y -= 100
            self.signin.alpha = 1.0
            self.signin.center.y -= 100
        }, completion: nil)
    }
   
    @IBAction func signup(_ sender: Any) {
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        delegate.gotoSignup()
        let a = SignupViewController()
        self.navigationController?.pushViewController(a, animated: true)
    }
    @IBAction func signin(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoSignin()
    }
}
