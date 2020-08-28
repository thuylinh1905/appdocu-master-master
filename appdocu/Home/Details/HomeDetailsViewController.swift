//
//  HomeDetailsViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/24/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import Kingfisher

class HomeDetailsViewController: UIViewController {
    
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet var view1 : UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var mota: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    var NewFeedDetails : NewFeedDetail!
    var selectedIndexPath: NSIndexPath?
    var mota1 : String!
    var mang : [String] = []
    var mang1 : [String] = []
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableHeaderView = view1
        truyenve()
        tableview.register(UINib(nibName: "HomeDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "homedetails")
        collectionview.register(UINib(nibName: "HomeDetailsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "collectionviewdetails")
//        sizeHeaderToFit()
        pagecontrol.numberOfPages = NewFeedDetails.image.count
        pagecontrol.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.change), userInfo: nil, repeats: true)
        }
    }
         @objc func change() {
          var counter = 0
         if counter < NewFeedDetails.image.count {
             let index = IndexPath.init(item: counter, section: 0)
             self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pagecontrol.currentPage = counter
             counter += 1
         } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.collectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             pagecontrol.currentPage = counter
             counter = 1
         }
             
         }
    
    func truyenve() {
        tencongthuc.text = NewFeedDetails.tencongthuc
        mota.text = NewFeedDetails.motacongthuc
        mota.sizeToFit()
        view1.frame.size.height = mota.frame.size.height + tencongthuc.frame.size.height + 400
        username.text = NewFeedDetails.username
        KingfisherManager.shared.retrieveImage(with: URL(string: NewFeedDetails.imageprofile)! as Resource, options: nil, progressBlock: nil) { (image, error, cache, url) in
            self.image.image = image
        }
    }
}
extension HomeDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homedetails", for: indexPath) as! HomeDetailsTableViewCell
            cell.txt.text = mang[indexPath.row]
            print(cell)
            return cell
    }
    
}
extension HomeDetailsViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewFeedDetails.image.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewdetails", for: indexPath) as! HomeDetailsCollectionViewCell
        cell.truyenvecolletion(image: NewFeedDetails.image[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
