//
//  UsersFoodTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/3/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class UsersFoodTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        
        @IBOutlet weak var tencongthuc: UILabel!
        @IBOutlet weak var songuoi: UILabel!
        @IBOutlet weak var mota: UILabel!
        @IBOutlet weak var imagefood : UICollectionView!
        @IBOutlet weak var view: UIView!
        var hinh : [String] = []
        var userfoodimage : Userfood!
        var newFeed: NewFeedmodel1!
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func truyen(Newfeed : NewFeedmodel1) {
//            userfoodimage = newFeed
            self.newFeed = Newfeed
            tencongthuc.text = Newfeed.tencongthuc
            songuoi.text = Newfeed.khauphan
            mota.text = Newfeed.motacongthuc
            imagefood.delegate = self
            imagefood.dataSource = self
            imagefood.register(UINib(nibName: "UserfoodCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "userfoodcell")
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.newFeed.image.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = imagefood.dequeueReusableCell(withReuseIdentifier: "userfoodcell", for: indexPath) as! UserfoodCollectionViewCell
            cell.truyenanh(imagestring: newFeed.image[indexPath.row])
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: imagefood.frame.size.width, height: imagefood.frame.size.height)
        }
    }
