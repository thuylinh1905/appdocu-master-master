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

struct FollowedUser {
    var username : String
    var image : String
    var uid : String
    init(username : String , image : String , uid : String) {
        self.uid = uid
        self.username = username
        self.image = image
    }
}

class ProfileOtherUserViewController: UIViewController {
    
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var addfriend: UIButton!
    @IBOutlet weak var friend: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var viewheader: UIView!
    @IBOutlet weak var headerviewcell: UILabel!
    @IBOutlet var headerviewsection: UIView!
    @IBOutlet weak var fiendcount: UILabel!
    var followed : [FollowedUser] = []
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
        following()
        followeduser()
        self.addfriend.setBackgroundColor(color: UIColor.white, forState: .selected)
        self.addfriend.setTitleColor(UIColor.black, for: .selected)
    }

    @IBAction func addfriend(_ sender: Any) {
        self.addfriend.isSelected = true
        let userid = Auth.auth().currentUser?.uid
        let keyuid = uid
        let username = self.username.text
        let post = ["username" : username!,
                    "imageprofile" : images,
                    "uid" : keyuid!] as [String:Any]
        var postuser = ["uid" : userid!] as [String:Any]
        let userprofile = ref.child("users").child(userid!)
        userprofile.observeSingleEvent(of: .value) { (snapshot) in
            let userdic = snapshot.value as! NSDictionary
            postuser["username"] = userdic.value(forKey: "username")
            postuser["image"] = userdic.value(forKey: "image")
            let childupdate = ["/Following/\(String(describing: userid!))/\(keyuid!)/": post,
                               "/FollowedUser/\(String(describing: keyuid!))/\(userid!)/": postuser]
            self.ref.updateChildValues(childupdate)
        }
        
    }
    func following() {
        let userid = Auth.auth().currentUser?.uid
        let keyuid = uid
        ref.child("Following").child(userid!).child(keyuid!).observe(.value) { (snapshot) in
            if let dic = snapshot.value as? [String:Any] {
                let username1 = dic["username"] as! String
                self.addfriend.isSelected = true
                self.fiendcount.text = username1
                self.tableview.reloadData()
            } else {
                self.addfriend.isSelected = false
            }
        }
    }
    func followeduser() {
        let keyuid = uid
        ref.child("FollowedUser").child(keyuid!).observe(.childAdded) { (snapshot) in
            print(snapshot)
            if let dic = snapshot.value as? [String:Any] {
                print(dic)
                let uid = dic["uid"] as! String
                let username = dic["username"] as! String
                let imageprofile = dic["image"] as! String
                let post1 = FollowedUser(username: username, image: imageprofile, uid: uid)
                self.followed.append(post1)
                self.tableview.reloadData()
            }
            self.fiendcount.text = String(self.followed.count)
        }
    }
    func truyenve() {
        ref.child("users").child(uid!).observe(.value , with:  { (snapshot) in
            let dictionary = snapshot.value as! [String:Any]
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath) as! ProfileOtherUserTableViewCell
        let tencongthuc = cell.NewFeed.tencongthuc
        let motacongthuc = cell.NewFeed.motacongthuc
        let khauphan = cell.NewFeed.khauphan
        let thoigiannau = cell.NewFeed.thoigiannau
        let username = cell.NewFeed.username!
        let image = cell.NewFeed.image!
        let imageprofile = cell.NewFeed.imageprofile
        let nguyenlieu = cell.NewFeed.nguyenlieu
        let congthuc = cell.NewFeed.congthuc
        let keyid = cell.NewFeed.keyid
        let like = cell.NewFeed.like
        let uid = cell.NewFeed.uid
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid , like : like , uid:  uid)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.NewFeed = array
        self.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
}
