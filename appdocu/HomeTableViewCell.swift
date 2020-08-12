//
//  HomeTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/9/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var post : UILabel!
    @IBOutlet weak var imageprofile : UIImageView!
    @IBOutlet weak var colletion: UICollectionView!
    var newFeed: NewFeedmodel1!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colletion.delegate = self
        colletion.dataSource = self
    }
    
    func truyenve(Newfeed : NewFeedmodel1) {
        self.newFeed = Newfeed
        colletion.register(UINib(nibName: "HomeNewFeedCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "newfeedcollectionview")
        username.text = Newfeed.username
        post.text = Newfeed.mota
        if let profileimage = Newfeed.imageprofile {
            if let url = URL(string: profileimage){
                print(url)
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                    self.imageprofile.image = image
                }
            }
        }
        self.colletion.reloadData()
    }
}
extension HomeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newFeed.image.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newfeedcollectionview", for: indexPath) as! HomeNewFeedCollectionViewCell
        print("day la mang image/\(self.newFeed.image!)")
        //        print("cell của collection/\(self.newFeed.image[indexPath.row])")
        cell.truyenve(truyenim: self.newFeed.image[indexPath.row])
        return cell
    }
}
