//
//  UsersaveViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/5/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol reload {
    func reloaddata()
}

class UsersaveViewController: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    static var usersave : [NewFeedmodel1] = []
    var sliderViewController: UISimpleSlidingTabController?
    
    convenience init(superViewController: UISimpleSlidingTabController) {
        self.init()
        self.sliderViewController = superViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.register(UINib(nibName: "UsersaveCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "usersave")
        collectiondata()
    }
    func collectiondata() {
        let ref = Database.database().reference()
        let key = Auth.auth().currentUser?.uid
        ref.child("Save-User").child(key!).observe(.childAdded) { (snapshot) in
            if let dic = snapshot.value as? [String:Any] {
                let tencongthuc = dic["tencongthuc"] as! String
                let motacongthuc = dic["motacongthuc"] as! String
                let khauphan = dic["khauphan"] as! String
                let thoigiannau = dic["thoigiannau"] as! String
                let nguyenlieu = dic["nguyenlieu"] as! [String]
                let congthuc = dic["congthucnau"] as! [String]
                let username = dic["username"] as! String
                let imageprofile = dic["imageprofile"] as! String
                let image =  dic["image"] as! [String]
                let keyid = dic["keyid"] as! String
                let like = dic["like"] as! Int
                let uid = dic["uid"] as! String
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid, like: like , uid : uid)
                UsersaveViewController.self.usersave.insert(post1, at: 0)
                print(UsersaveViewController.self.usersave)
                self.collectionview.reloadData()
            }
        }
    }
    
}
extension UsersaveViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UsersaveViewController.usersave.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "usersave", for: indexPath) as! UsersaveCollectionViewCell
        cell.truyenve(usersave: UsersaveViewController.usersave[indexPath.row])
        cell.delegate = self
        cell.usersavecontroller = self
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left:  5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthVal = self.view.frame.width
        
        return CGSize(width: widthVal / 2 - 10   , height:  250 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionview.cellForItem(at: indexPath) as! UsersaveCollectionViewCell
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
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid , like: like , uid: uid)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.NewFeed = ProfileUserViewController.arraynewfeed
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.sliderViewController?.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
extension UsersaveViewController : ParentControllerDelegate {
    func requestReloadTable() {
        collectionview.reloadData()
    }
    
}
