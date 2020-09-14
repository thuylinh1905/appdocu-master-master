import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import Kingfisher
import DKImagePickerController
import FirebaseStorage
import SVProgressHUD

class PostViewController: UIViewController  {
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tencongthuc: UITextView!
    @IBOutlet weak var motacongthuc : UITextView!
    @IBOutlet weak var txtkhauphan: UITextField!
    @IBOutlet weak var txtthoigiannau: UITextField!
    var imagecollection : [UIImage]! = []
    static var imagecollection1 : [UIImage]! = []
    var updateimage : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        collectionview.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "collection")
        self.hideKeyboard()
        collectionview.delegate =  self
        collectionview.dataSource = self
        textview()
        textfieldbuttomLine()
    }
}
extension PostViewController {
    @IBAction func moanh(_ sender: Any) {
        let pickerController = DKImagePickerController()
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for asset in assets {
                asset.fetchOriginalImage { (image, if) in
                    print(image!)
                    self.imagecollection.append(image!)
                    print(self.imagecollection!)
                    PostViewController.self.imagecollection1.append(contentsOf: self.imagecollection)
                    print(PostViewController.self.imagecollection1.count)
                    self.collectionview.reloadData()
                    self.imagecollection.removeAll()
                }
            }
        }
        self.present(pickerController, animated: true) {}
    }
    @IBAction func addview(_ sender: Any) {
        let postdetails = addingredientsViewController()
        postdetails.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(postdetails, animated: true)
    }
    func navibutton() {
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationItem.title = "Đăng bài"
        let btnUpload = UIButton()
        btnUpload.setTitleColor(.white, for: .normal)
        btnUpload.setTitle("Đăng", for: .normal)
        btnUpload.setTitleColor(.black, for: .normal)
        btnUpload.addTarget(self, action: #selector(uploadfile), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnUpload
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func uploadfile(){
        SVProgressHUD.show(withStatus: "Loading...")
        let tencongthuc1 = tencongthuc.text
        let motacongthuc1 = motacongthuc.text
        let khauphan = txtkhauphan.text
        let thoigiannau = txtkhauphan.text
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        guard let key = ref.child("location").child("2").childByAutoId().key else { return }
        var post = ["uid": userID!,
                    "tencongthuc": tencongthuc1!,
                    "motacongthuc" : motacongthuc1!,
                    "khauphan": khauphan!,
                    "thoigiannau": thoigiannau!,
                    "nguyenlieu" : addingredientsViewController.nguyenlieu,
                    "congthucnau" : addingredientsViewController.congthuc,
                    "like" : 0,
                    "keyid" : key] as [String: Any]
        let childRef = ref.child("TWEETS").child(userID!).childByAutoId()
        for i in PostViewController.imagecollection1 {
            let storageRef = Storage.storage().reference(forURL: "gs://appdocu-2c67f.appspot.com")
            let postRef = childRef.child("image")
            let autoID = postRef.childByAutoId().key
            let childStorageRef = storageRef.child("ImageUserPost").child(userID!).child(autoID!)
            let tweetImage = i
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            if let uploadData = tweetImage.jpegData(compressionQuality: 0.7 ) {
                childStorageRef.putData(uploadData, metadata: metaData, completion: {
                    (storagemetadata,error) in
                    if error != nil{
                        SVProgressHUD.showError(withStatus: "Đã lỗi khi Upload bài")
                    } else {
                        childStorageRef.downloadURL(completion: {
                            (url,error) in
                            if let ImageUrl = url?.absoluteString {
                                let userImage = ref.child("users").child(userID!)
                                userImage.observeSingleEvent(of: .value) { (snapshot) in
                                    let usersdic = snapshot.value as! NSDictionary
                                    post["Imageprofile"] = usersdic.value(forKey: "image")
                                    post["username"] = usersdic.value(forKey: "username")
                                    self.updateimage.append(ImageUrl)
                                    print(ImageUrl)
                                    post["image"] = self.updateimage
                                    let childUpdates = ["/NewPeedPost/\(key)": post,
                                                        "/user-NewPeedPost/\(String(describing: userID!))/\(key)/": post]
                                    ref.updateChildValues(childUpdates)
                                }
                            }
                        })
                    }
                })
            }
        }
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gototabbar()
        SVProgressHUD.showSuccess(withStatus: "Đã Upload")
    }
    
}

extension PostViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PostViewController.self.imagecollection1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionViewCell
        cell.parentDelegate = self
        cell.truyen(image: PostViewController.imagecollection1[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200 , height:  200)
    }
}
extension PostViewController : ParentControllerDelegate{
    func requestReloadTable() {
        self.collectionview.reloadData()
    }
}
extension PostViewController : UITextViewDelegate {
    func textview() {
        tencongthuc.text = "Tên công thức"
        tencongthuc.textColor = UIColor.lightGray
        tencongthuc.translatesAutoresizingMaskIntoConstraints = false
        tencongthuc.isScrollEnabled = false
        tencongthuc.delegate = self
        tencongthuc.font = UIFont.systemFont(ofSize: 20)
        
        motacongthuc.text = "Mô tả công thức"
        motacongthuc.textColor = UIColor.lightGray
        motacongthuc.translatesAutoresizingMaskIntoConstraints = false
        motacongthuc.isScrollEnabled = false
        motacongthuc.delegate = self
        motacongthuc.font = UIFont.systemFont(ofSize: 20)
    }
    func textfieldbuttomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtkhauphan.frame.height - 1, width: txtkhauphan.frame.width, height: 0.5)
        bottomLine.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        txtkhauphan.borderStyle = UITextField.BorderStyle.none
        txtkhauphan.layer.addSublayer(bottomLine)
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: txtthoigiannau.frame.height - 1, width: txtthoigiannau.frame.width, height: 0.5)
        bottomLine1.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        txtthoigiannau.borderStyle = UITextField.BorderStyle.none
        txtthoigiannau.layer.addSublayer(bottomLine1)
    }
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint ) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
        }
    }
}
