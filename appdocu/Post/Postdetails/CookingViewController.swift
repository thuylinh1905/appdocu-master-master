//
//  CookingViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/30/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class CookingViewController: UIViewController {

    @IBOutlet var tablecongthucheader: UIView!
     @IBOutlet var viewcongthuc: UIView!
    @IBOutlet weak var congthuctext: UITextView!
     @IBOutlet weak var tableviewcongthuc: UITableView!
    var congthuc = [String]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
