//
//  HomeDetailsViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/24/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseAuth

struct  UserComment {
    var image : String
    var username : String
    var comment : String
    init(image : String , username : String , comment : String) {
        self.image = image
        self.username = username
        self.comment =  comment
    }
}

class HomeDetailsViewController: UIViewController {
    
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet var view1 : UIView!
    @IBOutlet var viewcomment: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var mota: UILabel!
    @IBOutlet weak var commnet: UITextView!
    @IBOutlet weak var collectionview: UICollectionView!
    var NewFeedDetails : NewFeedDetail!
    var selectedIndexPath: NSIndexPath?
    var arrayCommnet = [UserComment]()
    var mota1 : String!
    var mang : [String] = []
    var mang1 : [String] = []
    var timer = Timer()
    var commentuser : [UserComment] = []
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableHeaderView = view1
        truyenve()
        tableview.register(UINib(nibName: "HomeDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "homedetails")
        tableview.register(UINib(nibName: "CookingHomeDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "cookinghomedetails")
        tableview.register(UINib(nibName: "CommentTableViewCell", bundle: .main), forCellReuseIdentifier: "commentcell")
        collectionview.register(UINib(nibName: "HomeDetailsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "collectionviewdetails")
        pagecontrol.numberOfPages = NewFeedDetails.image.count
        pagecontrol.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.change), userInfo: nil, repeats: true)
        }
        tablecomment()
    }
    func tablecomment(){
        let key = NewFeedDetails.keyid
        let ref = Database.database().reference()
        ref.child("NewPeedPost").child(key).child("Comment-User").observe(.childAdded) { (snashot) in
            if let dic = snashot.value as? [String:Any] {
                let username = dic["username"] as! String
                let imageprofile = dic["imageprofile"] as! String
                let comment = dic["comment"] as! String
                let commnentuser = UserComment(image: imageprofile, username: username, comment: comment)
                self.commentuser.append(commnentuser)
                self.tableview.reloadData()
            }
        }
    }
    @IBAction func comment(_ sender: Any) {
        self.view.addSubview(viewcomment)
        viewcomment.center = self.view.center
        self.showAnimate()
    }
    @IBAction func outview(_ sender: Any) {
        self.viewcomment.removeFromSuperview()
    }
    @IBAction func agreecongthuc(_ sender: Any) {
        self.viewcomment.removeFromSuperview()
        let ref1 = Database.database().reference()
        let key = NewFeedDetails.keyid
        let ref = Database.database().reference().child("NewPeedPost").child(key)
        guard let key1 = ref.child("comment").childByAutoId().key else { return }
        let userID = Auth.auth().currentUser?.uid
        let comment = commnet.text
        var post = ["uid": userID!,
                    "comment" : comment! ] as [String: Any]
        let userImage = ref1.child("users").child(userID!)
        userImage.observeSingleEvent(of: .value) { (snapshot) in
            let usersdic = snapshot.value as! NSDictionary
            post["imageprofile"] = usersdic.value(forKey: "image")
            post["username"] = usersdic.value(forKey: "username")
            let childUpdates = ["/Comment-User/\(key1)": post]
            ref.updateChildValues(childUpdates)
        }
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.NewFeedDetails.nguyenlieu.count
        } else if section == 1{
            return self.NewFeedDetails.congthuc.count
        } else {
            return self.commentuser.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homedetails", for: indexPath) as! HomeDetailsTableViewCell
            cell.txt.text = NewFeedDetails.nguyenlieu[indexPath.row]
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cookinghomedetails", for: indexPath) as! CookingHomeDetailsTableViewCell
            cell.txtcongthuc.text = NewFeedDetails.congthuc[indexPath.row]
            cell.number.text = String(indexPath.row) + "."
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentcell", for: indexPath) as! CommentTableViewCell
            cell.truyenve(commentuser: commentuser[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Nguyên liệu"
        } else if section == 1{
            return "Công thức"
        } else {
            return "Bình luận"
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = .black
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        } else if section == 1{
            return 50
        } else {
            return 50
        }
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
