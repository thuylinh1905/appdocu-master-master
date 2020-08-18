//
//  MenuProfileViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/10/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class MenuProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var Menu: [MenuModel] = []
    var mon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let m1 = [MenuModel(menuname: "Chỉnh sửa trang cá nhân"),
                  MenuModel(menuname: "Cài đặt thông báo"),
                  MenuModel(menuname: "Tài khoản và bảo mật")]
        Menu.append(contentsOf: m1)
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: .main), forCellReuseIdentifier: "menutable")
    }
}
extension MenuProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Menu.count)
        return Menu.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menutable", for: indexPath) as! MenuTableViewCell
        cell.truyenve(menu: Menu[indexPath.row])
        print(Menu)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        mon = cell.tt.text ?? ""
        print(mon)
        switch mon {
        case "Chỉnh sửa trang cá nhân":
            print("1")
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.gotoSignin()
        case "Cài đặt thông báo" :
            print("2")
        default:
            print("0")
        }
    }
}
