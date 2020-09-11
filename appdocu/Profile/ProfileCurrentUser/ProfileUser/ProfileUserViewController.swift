//
//  ProfileUserViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/1/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage

class ProfileUserViewController: UISimpleSlidingTabController {
    
    @IBOutlet var viewheader: UIView!
    @IBOutlet var viewnavigation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = viewnavigation
        addItem(item: UserfooodViewController(superViewController: self), title: "Món của tôi")
        addItem(item: UsersaveViewController(superViewController: self), title: "Món Ăn đã lưu")
        setHeaderActiveColor(color: .orange)
        setHeaderInActiveColor(color: .black)
        setHeaderBackgroundColor(color: .white)
        build()
        navibutton()
    }
    func navibutton() {
        let btmore = UIButton()
        btmore.setImage(UIImage(named: "more"), for: .normal)
        btmore.addTarget(self, action:  #selector(gotoprofile), for: .touchUpInside)
        let rightbarbutton = UIBarButtonItem()
        rightbarbutton.customView = btmore
        
        self.navigationItem.rightBarButtonItem = rightbarbutton
    }
    func Alertcontroller() {
        let alertcontroller = UIAlertController()
        let button1 = UIAlertAction(title: "Xem trang bếp cá nhân ", style: .default) { (action) in
            let profile = ProfileViewController()
            self.navigationController?.pushViewController(profile, animated: true)
        }
        let button2 = UIAlertAction(title: "Cài đặt", style: .default){(action) in
            let setting = UserProfileViewController()
            self.navigationController?.pushViewController(setting, animated: true)
        }
        let button3 = UIAlertAction(title: "Thoát", style: .cancel) { (action) in
        }
        alertcontroller.addAction(button1)
        alertcontroller.addAction(button2)
        alertcontroller.addAction(button3)
        self.present(alertcontroller, animated: true, completion: nil)
    }
    @objc func gotoprofile() {
        Alertcontroller()
    }
}
