import UIKit
import FirebaseAuth
import  FirebaseDatabase
import FirebaseStorage
import Kingfisher

class ProfileViewController: UIViewController {
    
    //    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var huhu : UILabel!
    @IBOutlet weak var email : UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    var ref: DatabaseReference!
    var datahandle : DatabaseHandle!
    var modelusers = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.layer.cornerRadius = 85
        imageview.layer.borderWidth = 5
        imageview.layer.borderColor = UIColor.white.cgColor
        truyenve()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        navibutton()
    }
    func navibutton() {
        let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "setting"), for: .normal)
        btnCancel.addTarget(self, action:  #selector(goToSetting), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        self.navigationItem.rightBarButtonItem = leftBarButton
    }
    @objc func goToSetting(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoHome22()
    }
    @IBAction func Signout(){
        do {
            try Auth.auth().signOut()
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.gotoOnboarding()
        } catch let error {
            print(error)
        }
    }
    //    func truyenve() {
    //        ref = Database.database().reference()
    //        datahandle =  ref.child("users").child(Auth.auth().currentUser?.uid ?? "").observe(.value) { (snapshot) in
    //            for user in snapshot.children.allObjects as! [DataSnapshot] {
    //                let users = user.value as? [String : AnyObject]
    //                let email = users?["email"]
    //                let image = users?["image"]
    //                let phone = users?["phone"]
    //                let status = users?["status"]
    //                let listuser = UserModel(email: email as! String, image: image as! String, phone: phone as! String, status: status as! String)
    //                self.modelusers.append(listuser)
    //                print(self.modelusers)
    //            }
    //            self.tableuser.reloadData()
    //        }
    //    }
    
    func truyenve() {
        ref = Database.database().reference()
        if let userid = Auth.auth().currentUser?.uid {
            ref.child("users").child(userid).observe(.value , with:  { (snapshot) in
                let dictionary = snapshot.value as! NSDictionary
                let email = dictionary["email"] as? String
                let username = dictionary["username"] as? String
                if let profileimage = dictionary["image"] as? String {
                    if let url = URL(string: profileimage){
                        KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                            self.imageview.image = image
                        }
                    }
                }
                self.email.text = email
                self.username.text = username
            })

        }

    }
    
}


