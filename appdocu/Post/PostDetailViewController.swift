//
//  PostDetailViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/29/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var segmentedcntroll: UISegmentedControl!
    @IBOutlet weak var viewcontroller: UIView!
    var views : [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        views = [UIView]()
//        views.append(addingredientsViewController().view)
//        views.append(CookingViewController().view)
//        for v in views {
//            viewcontroller.addSubview(v)
//        }
//        viewcontroller.bringSubviewToFront(views[0])
        viewcontroller.addSubview(addingredientsViewController().view)
    }
    @IBAction func selectview(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewcontroller = addingredientsViewController().view
        } else {
            viewcontroller = CookingViewController().view
        }
    }
}
