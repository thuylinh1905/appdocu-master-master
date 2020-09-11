import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var viewheader: UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var addfriend: UIButton!
    var ref: DatabaseReference!
    var datahandle : DatabaseHandle!
    var modelusers = [UserModel]()
    var array = [NewFeedmodel1]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableHeaderView = viewheader
        imageview.layer.cornerRadius = imageview.layer.frame.width / 2
        imageview.layer.borderWidth = 5
        imageview.layer.borderColor = UIColor.white.cgColor
        tableview.register(UINib(nibName: "ProfileTableViewCell", bundle: .main), forCellReuseIdentifier: "profilecell")
        truyenve()
        tabledata()
        self.hideKeyboard()
    }
    func truyenve() {
        ref = Database.database().reference()
        if let userid = Auth.auth().currentUser?.uid {
            ref.child("users").child(userid).observe(.value , with:  { (snapshot) in
                let dictionary = snapshot.value as! NSDictionary
                let username = dictionary["username"] as? String
                if let profileimage = dictionary["image"] as? String {
                    if let url = URL(string: profileimage){
                        KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                            self.imageview.image = image
                        }
                    }
                }
                self.username.text = username
            })
        }
    }
    func tabledata() {
         let userid = Auth.auth().currentUser?.uid
         let ref = Database.database().reference()
         ref.child("user-NewPeedPost").child(userid!).observe(.childAdded) { (snapshot) in
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
                                let like = dic["like"] as! Int
                                let uid = dic["uid"] as! String
                                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid, like: like , uid : uid)
                 self.array.append(post1)
                 self.tableview.reloadData()
             }
         }
     }
}
extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Món của tôi"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "profilecell", for: indexPath) as! ProfileTableViewCell
        cell.truyenve(newfeed: array[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

