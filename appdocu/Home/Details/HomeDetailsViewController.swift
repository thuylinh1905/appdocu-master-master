//
//  HomeDetailsViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/24/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Kingfisher
import SDWebImage

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
    var NewFeed : [NewFeedmodel1] = []
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
        pagecontrol.numberOfPages = NewFeedDetails.image.count
        pagecontrol.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.change), userInfo: nil, repeats: true)
        }
        imageuser.layer.cornerRadius = imageuser.frame.size.height / 2
        user()
        tablecomment()
    }
    @IBAction func like(_ sender: Any) {
        buttonlike.isSelected = true
    }    
    @IBAction func save(_ sender: Any) {
        let ref = Database.database().reference()
        let userid = Auth.auth().currentUser?.uid
        let key = NewFeedDetails.keyid
        let post = ["imageprofile" : NewFeedDetails.imageprofile!,
                    "congthucnau" : NewFeedDetails.congthuc!,
                    "image" : NewFeedDetails.image!,
                    "keyid" : NewFeedDetails.keyid,
                    "khauphan" : NewFeedDetails.khauphan,
                    "motacongthuc" : NewFeedDetails.motacongthuc,
                    "nguyenlieu" : NewFeedDetails.nguyenlieu!,
                    "tencongthuc" : NewFeedDetails.tencongthuc,
                    "thoigiannau" : NewFeedDetails.thoigiannau,
                    "username" : NewFeedDetails.username!] as [String:Any]
        let childupdate = ["/Save-User/\(String(describing: userid!))/\(key)/": post]
        ref.updateChildValues(childupdate)
    }
    @IBAction func opencomment(_ sender: Any) {
        let comment = CommentViewController()
        comment.delegate = self
        self.present(UINavigationController(rootViewController: comment), animated: true, completion: nil)
    }
    func user() {
        let ref = Database.database().reference()
        if let userid = Auth.auth().currentUser?.uid {
            ref.child("users").child(userid).observe(.value , with:  { (snapshot) in
                let dictionary = snapshot.value as! NSDictionary
                if let profileimage = dictionary["image"] as? String {
                    self.imageuser.sd_setImage(with: URL(string: profileimage))
                }
            })
        }
    }
    
    func tablecomment(){
        let ref = Database.database().reference()
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
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentcell", for: indexPath) as! CommentTableViewCell
            cell.truyenve(commentuser: commentuser[indexPath.row])
            tableView.separatorStyle = .none
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
extension HomeDetailsViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionview {
            return NewFeedDetails.image.count
        } else {
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionview {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewdetails", for: indexPath) as! HomeDetailsCollectionViewCell
            cell.truyenvecolletion(image: NewFeedDetails.image[indexPath.row])
            return cell
        } else {
            let cell = collectionmore.dequeueReusableCell(withReuseIdentifier: "morecollectionview", for: indexPath) as! MoreCollectionViewCell
            cell.tencongthuc.text = NewFeed[indexPath.row].tencongthuc
            let first5 = NewFeed[indexPath.row].image.prefix(1)
            for i in first5 {
                cell.image.sd_setImage(with: URL(string: i), placeholderImage: UIImage(named: "placeholder"))
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionview {
            let size = collectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        } else {
            let size = collectionmore.frame.size
            return CGSize(width: size.width / 2 - 5, height: size.height / 2 - 5 )
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionview {
            return 0.0
        } else {
            return 5
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
