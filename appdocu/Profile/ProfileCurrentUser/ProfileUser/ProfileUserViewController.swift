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
    static var arraynewfeed : [NewFeedmodel1] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = viewnavigation
        addItem(item: UserfooodViewController(superViewController: self), title: "Món của tôi")
        addItem(item: UsersaveViewController(superViewController: self), title: "Món Ăn đã lưu")
        setHeaderActiveColor(color: .white)
        setHeaderInActiveColor(color: .black)
        setHeaderBackgroundColor(color: UIColor.orange)
        build()
        navibutton()
        datacollection()
        navigationbar()
    }
    func navigationbar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
    }
    func datacollection() {
           let ref = Database.database().reference()
           ref.child("NewPeedPost").observe(.childAdded) { (snashot) in
               if let dic = snashot.value as? [String:Any] {
                   let tencongthuc = dic["tencongthuc"] as! String
                   let motacongthuc = dic["motacongthuc"] as! String
                   let khauphan = dic["khauphan"] as! String
                   let thoigiannau = dic["thoigiannau"] as! String
                   let nguyenlieu = dic["nguyenlieu"] as! [String]
                   let congthuc = dic["congthucnau"] as! [String]
                   let username = dic["username"] as! String
                   let imageprofile = dic["Imageprofile"] as! String
                   let image =  dic["image"] as! [String]
                   let keyid = dic["keyid"] as! String
                   let like = dic["like"] as! Int
                   let uid = dic["uid"] as! String
                   let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid, like: like , uid : uid)
                ProfileUserViewController.self.arraynewfeed.insert(post1, at: 0)
               }
           }
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
