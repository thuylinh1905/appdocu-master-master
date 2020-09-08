import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var viewheader: UIView!
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
        tableview.tableHeaderView = viewheader
        imageview.layer.cornerRadius = imageview.layer.frame.width / 2
        imageview.layer.borderWidth = 5
        imageview.layer.borderColor = UIColor.white.cgColor
        truyenve()
        self.hideKeyboard()
    }
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


