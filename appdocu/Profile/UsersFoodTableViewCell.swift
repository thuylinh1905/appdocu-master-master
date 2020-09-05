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
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func truyen(userfood : Userfood) {
            userfoodimage = userfood
            tencongthuc.text = userfood.tencongthuc
            songuoi.text = userfood.khauphan
            mota.text = userfood.motacongthuc
            imagefood.delegate = self
            imagefood.dataSource = self
            imagefood.register(UINib(nibName: "UserfoodCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "userfoodcell")
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.userfoodimage.image.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = imagefood.dequeueReusableCell(withReuseIdentifier: "userfoodcell", for: indexPath) as! UserfoodCollectionViewCell
            cell.truyenanh(imagestring: userfoodimage.image[indexPath.row])
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: imagefood.frame.size.width, height: imagefood.frame.size.height)
        }
    }