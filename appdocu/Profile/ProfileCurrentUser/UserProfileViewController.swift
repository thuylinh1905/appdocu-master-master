//
//  UserProfileViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/20/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage

struct MenuSetting {
    var name : String!
    var image : UIImage!
    
    init(name : String, image : UIImage) {
        self.name = name
        self.image = image
    }
}

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var txtusername: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var imagequangcao: UIImageView!
    var mang : [MenuSetting] = []
    var mang1 = [["cai đat", "khakh", "hdkhd"],
                ["sÂsASas", "gagsj" , "sdjhaj"],
                "bạasas"] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Menu"
        tableview.register(UINib(nibName: "MenuUserProfileTableViewCell", bundle: .main), forCellReuseIdentifier: "menuuser")
       addValue()
    }
    func addValue() {
         mang = [MenuSetting(name: "Thông tin tài khoản", image: UIImage(named: "myaccount")!),
                       MenuSetting(name: "Chỉnh sửa trang cá nhân", image: UIImage(named: "user")!),
                         MenuSetting(name: "Tài khoản và bảo mật", image: UIImage(named: "pass")!),
                           MenuSetting(name: "Bài viết đã lưu", image: UIImage(named: "mark")!),
                           MenuSetting(name: "Chia sẻ App", image: UIImage(named: "shareapp")!),
                           MenuSetting(name: "Thông tin về App", image: UIImage(named: "information")!),
                           MenuSetting(name: "Đăng xuất", image: UIImage(named: "logout")!)]
    }
}
extension UserProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuuser", for: indexPath) as! MenuUserProfileTableViewCell
        cell.truyenve(menuSetting: mang[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuUserProfileTableViewCell
        cell.selectedBackgroundView = UIView()
               cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
               tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let menuchoice = cell.txtthonfbao.text
        switch menuchoice {
        case "Thông tin tài khoản":
            print("1")
        case "Chỉnh sửa trang cá nhân" :
            print("2")
        case "Tài khoản và bảo mật" :
            print("3")
        case "Bài viết đã lưu" :
            print("4")
        case "Chia sẻ App" :
            print("5")
        case "Thông tin về App" :
            print("6")
        default:
            do {
                try Auth.auth().signOut()
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.gotoOnboarding()
            } catch let error {
                print(error)
            }
        }
    }
}
