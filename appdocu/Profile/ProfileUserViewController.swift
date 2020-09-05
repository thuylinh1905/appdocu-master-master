//
//  ProfileUserViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/1/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class ProfileUserViewController: UISimpleSlidingTabController {
    
    @IBOutlet var viewheader: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addItem(item: UserfooodViewController(), title: "Món của tôi")
        addItem(item: UsersaveViewController(), title: "Món Ăn đã lưu")
        setHeaderActiveColor(color: .white)
        setHeaderInActiveColor(color: .lightText)
        setHeaderBackgroundColor(color: .orange)
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
