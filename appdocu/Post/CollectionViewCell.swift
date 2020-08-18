//
//  CollectionViewCell.swift
//  app1
//
//  Created by thuylinh on 8/6/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import GameplayKit

protocol ParentControllerDelegate{
    func requestReloadTable()
}

class CollectionViewCell: UICollectionViewCell {
    
    var parentDelegate: ParentControllerDelegate?
    @IBOutlet weak var anh: UIImageView!
    
    func truyen(image : UIImage) {
        self.anh.image = image
    }
    
    @IBAction func buttonx(_ sender: Any) {
        let imagechoice = anh.image
        if let imagedelete = PostViewController.imagecollection1.firstIndex(of: imagechoice!){
            print("tim thay \(imagedelete)")
            PostViewController.imagecollection1.remove(at: imagedelete)
        }
        parentDelegate?.requestReloadTable()
    }
}
