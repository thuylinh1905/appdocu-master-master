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

struct UserSave {
    var tencongthuc : String
    var motacongthuc : String
    var khauphan : String
    var thoigiannau : String
    var username : String!
    var imageprofile : String!
    var image : [String]!
    var nguyenlieu : [String]!
    var congthuc : [String]!
    var keyid : String
    
    init(tencongthuc : String , motacongthuc : String, khauphan : String, thoigiannau : String, username : String , image : [String], imageprofile : String, nguyenlieu : [String] , congthuc : [String] , keyid : String) {
        self.tencongthuc = tencongthuc
        self.motacongthuc = motacongthuc
        self.khauphan = khauphan
        self.thoigiannau = thoigiannau
        self.username = username
        self.image = image
        self.imageprofile = imageprofile
        self.nguyenlieu = nguyenlieu
        self.congthuc = congthuc
        self.keyid = keyid
    }
}

class UsersaveViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    var usersave : [NewFeedmodel1] = []
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
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid, like: like)
                self.usersave.insert(post1, at: 0)
                self.collectionview.reloadData()
            }
        }
    }
    
}
extension UsersaveViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersave.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "usersave", for: indexPath) as! UsersaveCollectionViewCell
        cell.truyenve(usersave: usersave[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionview.frame.size.width / 2 - 10 , height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
