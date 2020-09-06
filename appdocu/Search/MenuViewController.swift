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

struct MenuFood {
    var name : String
    var image : String
    init(name : String, image : String) {
        self.name = name
        self.image = image
    }
}

class MenuViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    var menu : [MenuFood] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib(nibName: "MenuCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "menucollection")
        truyenmonan()
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
        cell.image.sd_setImage(with: URL(string: menu[indexPath.row].image))
        cell.name.text = menu[indexPath.row].name
        cell.image.layer.cornerRadius = 10
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
        let searchview = SearchViewController()
        self.navigationController?.pushViewController(searchview, animated: true)
    }
}
