import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class ProfileViewController: UIViewController {
    
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
        self.hideKeyboard()
        navibutton()
    }
    @IBAction func push(_ sender: Any) {
        let profileusser = ProfileUserViewController()
        self.navigationController?.pushViewController(profileusser, animated: true)
    }
    func navibutton() {
        let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "more"), for: .normal)
        btnCancel.addTarget(self, action:  #selector(goToSetting), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        self.navigationItem.rightBarButtonItem = leftBarButton
    }
    @objc func goToSetting(){
     let profileusser = ProfileUserViewController()
    self.navigationController?.pushViewController(profileusser, animated: true)
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


