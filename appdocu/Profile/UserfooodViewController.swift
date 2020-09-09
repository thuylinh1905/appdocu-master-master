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
    
    @IBOutlet weak var collection : UICollectionView!
    var array : [NewFeedmodel1] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib(nibName: "UserfoodCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "usersfood")
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
                let like = dic["like"] as! Int
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid, like: like)
                self.array.append(post1)
                self.collection.reloadData()
            }
        }
    }
}
extension UserfooodViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "usersfood", for: indexPath) as! UserfoodCollectionViewCell
        cell.truyen(Newfeed : array[indexPath.row])
        cell.view.layer.masksToBounds = true
        cell.view.layer.cornerRadius = 5
        cell.view.layer.borderWidth = 0.1
        cell.view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
        let cell = collection.cellForItem(at: indexPath) as! UserfoodCollectionViewCell
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
        let like = cell.newFeed.like
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid , like: like)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.NewFeed = array
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.sliderViewController?.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
