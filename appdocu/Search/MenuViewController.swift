//
//  MenuViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/6/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import FirebaseDatabase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    var array : [NewFeedmodel1] = []
    var menu : [MenuFood] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib(nibName: "MenuCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "menucollection")
        truyenmonan()
        tableviewdata()
        navigationbar()
    }
    func navigationbar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
    }
    func truyenmonan() {
        let db = Firestore.firestore()
        db.collection("menumonan").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dictionary = document.data()
                    let loaimon = dictionary["loaimon"] as! String
                    let hinhanh = dictionary["hinhanh"] as! String
                    let mangmenu = MenuFood(name: loaimon, image: hinhanh)
                    self.menu.append(mangmenu)
                }
            }
            self.collection.reloadData()
        }
    }
    func tableviewdata() {
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
                self.array.insert(post1, at: 0)
            }
        }
    }
}
extension MenuViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "menucollection", for: indexPath) as! MenuCollectionViewCell
        cell.truyenve(menufood: menu[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left:  5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthVal = self.view.frame.width
        
        return CGSize(width: widthVal / 2 - 10   , height:  120 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collection.cellForItem(at: indexPath) as! MenuCollectionViewCell
        let name = cell.cellmenu.name
        let searchview = SearchViewController()
        searchview.searchtext = name
        searchview.array1 = array
        self.navigationController?.pushViewController(searchview, animated: true)
    }
}
