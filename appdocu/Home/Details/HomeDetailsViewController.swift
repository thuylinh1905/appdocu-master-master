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

struct Usermore {
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


class HomeDetailsViewController: UIViewController {
    
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet var view1 : UIView!
    @IBOutlet var viewfooter: UIView!
    @IBOutlet var viewcomment: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imagecomment: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var mota: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var collectionmore: UICollectionView!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var buttonlike: UIButton!
    @IBOutlet weak var moreuser: UILabel!
    @IBOutlet weak var imageuser: UIImageView!
    var NewFeedDetails : NewFeedDetail!
    var selectedIndexPath: NSIndexPath?
    var arrayCommnet = [UserComment]()
    var mota1 : String!
    var mang : [String] = []
    var mang1 : [String] = []
    var timer = Timer()
    var commentuser : [UserComment] = []
    var counter = 0
    var usermore : [Usermore]!
    let ref = Database.database().reference()
 
    override func viewDidLoad() {
        super.viewDidLoad()
         comment.layer.cornerRadius = 15
         comment.layer.masksToBounds = true
         comment.layer.borderWidth = 1.0
        tableview.tableHeaderView = view1
        tableview.tableFooterView = viewfooter
        truyenve()
        tableview.register(UINib(nibName: "HomeDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "homedetails")
        tableview.register(UINib(nibName: "CookingHomeDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "cookinghomedetails")
        tableview.register(UINib(nibName: "CommentTableViewCell", bundle: .main), forCellReuseIdentifier: "commentcell")
        tableview.register(UINib(nibName: "TimeCookingTableViewCell", bundle: .main), forCellReuseIdentifier: "timecokking")
        collectionview.register(UINib(nibName: "HomeDetailsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "collectionviewdetails")
        collectionmore.register(UINib(nibName: "MoreCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "morecollectionview")
        collectionmore.delegate = self
        collectionmore.dataSource = self
        pagecontrol.numberOfPages = NewFeedDetails.image.count
        pagecontrol.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.change), userInfo: nil, repeats: true)
        }
       
        truyenve()
        tablecomment()
       
    }
    @IBAction func like(_ sender: Any) {
        buttonlike.isSelected = true
    }
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func opencomment(_ sender: Any) {
        let comment = CommentViewController()
        comment.delegate = self
        self.present(UINavigationController(rootViewController: comment), animated: true, completion: nil)
    }
    func tablecomment(){
        let key = NewFeedDetails.keyid
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
        
          func truyenve() {
              let userID = Auth.auth().currentUser?.uid
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
                      let post1 = Usermore(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid)
                      self.usermore.append(post1)
                      self.tableview.reloadData()
                  }
              }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.NewFeedDetails.nguyenlieu.count
        } else if section == 2 {
            return self.NewFeedDetails.congthuc.count
        } else {
            return self.commentuser.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timecokking", for: indexPath) as! TimeCookingTableViewCell
            cell.khauphan.text = NewFeedDetails.khauphan + " người"
            cell.thoigiannau.text = NewFeedDetails.thoigiannau
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homedetails", for: indexPath) as! HomeDetailsTableViewCell
            cell.txt.text = NewFeedDetails.nguyenlieu[indexPath.row]
            return cell
        } else if indexPath.section == 2 {
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
            return ""
        } else if section == 1 {
            return "Nguyên liệu"
        } else if section == 2 {
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
            return 10
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            return viewcomment
        } else {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return view
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 50
        } else {
            return 20
        }
    }
}
extension HomeDetailsViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionview {
            return NewFeedDetails.image.count
        } else {
            return self.usermore.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionview {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewdetails", for: indexPath) as! HomeDetailsCollectionViewCell
                   cell.truyenvecolletion(image: NewFeedDetails.image[indexPath.row])
                   return cell
        } else {
            let cell = collectionmore.dequeueReusableCell(withReuseIdentifier: "morecollectionview", for: indexPath) as! MoreCollectionViewCell
            cell.truyenve(usermore: usermore[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionview {
            let size = collectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        } else {
            let size = collectionmore.frame.size
            return CGSize(width: size.width, height: size.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionview {
              return 0.0
        } else {
            return 10.0
        }
      
    }
}
extension HomeDetailsViewController : comment {
    func commnetuser(commenttext: String) {
        self.dismiss(animated: true, completion: nil)
        let ref1 = Database.database().reference()
        let key = NewFeedDetails.keyid
        let ref = Database.database().reference().child("NewPeedPost").child(key)
        guard let key1 = ref.child("comment").childByAutoId().key else { return }
        let userID = Auth.auth().currentUser?.uid
        var post = ["uid": userID!,
                    "comment" : commenttext ] as [String: Any]
        let userImage = ref1.child("users").child(userID!)
        userImage.observeSingleEvent(of: .value) { (snapshot) in
            let usersdic = snapshot.value as! NSDictionary
            post["imageprofile"] = usersdic.value(forKey: "image")
            post["username"] = usersdic.value(forKey: "username")
            let childUpdates = ["/Comment-User/\(key1)": post]
            ref.updateChildValues(childUpdates)
        }
    }
}
