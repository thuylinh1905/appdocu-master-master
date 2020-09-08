//
//  UserfooodViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/1/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserfooodViewController: UIViewController {
    
    var sliderViewController: UISimpleSlidingTabController?
    convenience init(superViewController: UISimpleSlidingTabController) {
        self.init()
        self.sliderViewController = superViewController
    }
    
    @IBOutlet weak var tableview: UITableView!
    var array : [NewFeedmodel1] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "UsersFoodTableViewCell", bundle: .main), forCellReuseIdentifier: "usersfood")
        truyenve()
    }
    @IBAction func hihi(_ sender: Any) {
    }
    func truyenve() {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("user-NewPeedPost").child(userID!).observe(.childAdded) { (snapshot) in
            if let dic = snapshot.value as? [String:Any] {
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
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid)
                self.array.append(post1)
                self.tableview.reloadData()
            }
        }
    }
}
extension UserfooodViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersfood", for: indexPath) as! UsersFoodTableViewCell
        cell.truyen(Newfeed : array[indexPath.row])
        cell.view.layer.masksToBounds = true
        cell.view.layer.cornerRadius = 5
        cell.view.layer.borderWidth = 0.1
        cell.view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UsersFoodTableViewCell
        let tencongthuc = cell.newFeed.tencongthuc
                      let motacongthuc = cell.newFeed.motacongthuc
                      let khauphan = cell.newFeed.khauphan
                      let thoigiannau = cell.newFeed.thoigiannau
                      let username = cell.newFeed.username!
                      let image = cell.newFeed.image!
                      let imageprofile = cell.newFeed.imageprofile
                      let nguyenlieu = cell.newFeed.nguyenlieu
                      let congthuc = cell.newFeed.congthuc
                      let keyid = cell.newFeed.keyid
                      let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid)
                      let homeDetailViewcontroller = HomeDetailsViewController()
                      homeDetailViewcontroller.NewFeedDetails = NewFeed
                      homeDetailViewcontroller.NewFeed = array
                      homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.sliderViewController?.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
