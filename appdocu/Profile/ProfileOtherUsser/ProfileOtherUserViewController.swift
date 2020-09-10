//
//  ProfileOtherUserViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/10/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage

class ProfileOtherUserViewController: UIViewController {
    
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var addfriend: UIButton!
    @IBOutlet weak var friend: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var viewheader: UIView!
    @IBOutlet weak var headerviewcell: UILabel!
    @IBOutlet var headerviewsection: UIView!
    var uid : String!
    var array : [NewFeedmodel1] = []
    var images : String = ""
    let ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabledata()
        tableview.register(UINib(nibName: "ProfileOtherUserTableViewCell", bundle: .main), forCellReuseIdentifier: "profileOther")
        tableview.tableHeaderView = viewheader
        imageuser.layer.cornerRadius = imageuser.frame.size.height / 2
        addfriend.layer.cornerRadius = 15
        addfriend.layer.borderWidth = 0.5
        addfriend.layer.borderColor = UIColor.black.cgColor
        truyenve()
        self.addfriend.isSelected = true
    }
    @IBAction func addfriend(_ sender: Any) {
        self.addfriend.isSelected = true
        let userid = Auth.auth().currentUser?.uid
        let keyuid = uid
        let username = self.username.text
        let post = ["username" : username,
                    "imageprofile" : images]
        let childupdate = ["/Friends/\(String(describing: userid!))/\(keyuid!)/": post]
        ref.updateChildValues(childupdate)
    }
    func truyenve() {
        ref.child("users").child(uid!).observe(.value , with:  { (snapshot) in
            let dictionary = snapshot.value as! NSDictionary
            let username = dictionary["username"] as? String
            let profileimage = dictionary["image"] as? String
            self.imageuser.sd_setImage(with: URL(string: profileimage!))
            self.username.text = username
            self.images = profileimage!
        })
    }
    func tabledata() {
        let ref = Database.database().reference()
        ref.child("user-NewPeedPost").child(uid!).observe(.childAdded) { (snapshot) in
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
                let like = dic["like"] as! Int
                let uid = dic["uid"] as! String
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid, like: like , uid : uid)
                self.array.append(post1)
                self.tableview.reloadData()
            }
        }
    }
}
extension ProfileOtherUserViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerviewsection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileOther", for: indexPath) as! ProfileOtherUserTableViewCell
        cell.truyenve(newfeed: array[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
