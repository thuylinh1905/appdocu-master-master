import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import Kingfisher
import DKImagePickerController
import FirebaseStorage
import SVProgressHUD

struct loaimon {
    var ten : String!
    var hinhanh : String!
    init(ten : String, hinhanh : String) {
        self.ten = ten
        self.hinhanh = hinhanh
    }
}
class PostViewController: UIViewController  {
    
    @IBOutlet weak var loaidoan1: UIButton!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ts: UIImageView!
    @IBOutlet var select: UIView!
    @IBOutlet weak var txtmota: UITextField!
    @IBOutlet weak var txttenquan: UITextField!
    @IBOutlet weak var txtdiachi: UITextField!
    @IBOutlet weak var txtgiatien: UITextField!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var loaidoan: UIButton!
    @IBOutlet weak var textView: UITextView!
    var mon = ""
    var loaimonve = [loaimon]()
    var selectedindex : IndexPath?
    var imcolletion : [UIImage]! = []
    var imagecollection : [UIImage]! = []
    static var imagecollection1 : [UIImage]! = []
    var updateimage : [String] = []
    var assets = [DKAsset]()
    var aimage : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        self.tableview.register(UINib(nibName: "FoodTableViewCell", bundle: .main), forCellReuseIdentifier: "foodtableviewcell")
        collectionview.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "collection")
//        let view = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)![0] as! InputView
//        view.openCamera(moanh)
//        self.textView.inputAccessoryView = view
        self.hideKeyboard()
        collectionview.delegate =  self
        collectionview.dataSource = self
        self.truyenmonan()
        textview()
    }
    @IBAction func hihi(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading...")
               let mota = textView.text
               let giatien = txtgiatien.text
               let diachi = txtdiachi.text
               let tenquan = txttenquan.text
               let loaimon = loaidoan.titleLabel?.text
               let ref = Database.database().reference()
               let userID = Auth.auth().currentUser?.uid
               guard let key = ref.child("location").child("2").childByAutoId().key else { return }
               var post = ["uid": userID!,
                           "mota": mota!,
                           "loaimon" : loaimon!,
                           "giatien": giatien!,
                           "diachi": diachi!,
                           "tenquan" : tenquan!] as [String: Any]
               let childRef = ref.child("TWEETS").child(userID!).childByAutoId()
               for i in PostViewController.imagecollection1 {
                   let storageRef = Storage.storage().reference(forURL: "gs://appdocu-2c67f.appspot.com")
                   let postRef = childRef.child("image")
                   let autoID = postRef.childByAutoId().key
                   let childStorageRef = storageRef.child("ImagePost").child(userID!).child(autoID!)
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
                                           let childUpdates = ["/post/\(key)": post,
                                                               "/user-posts/\(String(describing: userID))/\(key)/": post]
                                           ref.updateChildValues(childUpdates)
                                           SVProgressHUD.showSuccess(withStatus: "Đã Upload")
                                           let delegate = UIApplication.shared.delegate as! AppDelegate
                                           delegate.gototabbar()
                                       }
                                   }
                               })
                           }
                       })
                   }
               }
    }
    func textview() {
        textView.text = "Bạn muốn đăng gì?"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 20)
    }
    @IBAction func uploadanh(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading")
        let mota = textView.text
        let giatien = txtgiatien.text
        let diachi = txtdiachi.text
        let tenquan = txttenquan.text
        let loaimon = loaidoan.titleLabel?.text
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        guard let key = ref.child("location").child("2").childByAutoId().key else { return }
        var post = ["uid": userID!,
                    "mota": mota!,
                    "loaimon" : loaimon!,
                    "giatien": giatien!,
                    "diachi": diachi!,
                    "tenquan" : tenquan!] as [String: Any]
        for i in PostViewController.imagecollection1 {
            guard let uploadData = i.jpegData(compressionQuality: 1.0) else { return }
            let storageRef = Storage.storage().reference(forURL: "gs://appdocu-2c67f.appspot.com")
            let storageProfileRef = storageRef.child("imageProfile")
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            storageProfileRef.putData(uploadData, metadata: metaData, completion: {
                (storagemetadata,error) in
                if error != nil{
                    return
                }
                storageProfileRef.downloadURL(completion: {
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
                            let childUpdates = ["/post/\(key)": post,
                                                "/user-posts/\(String(describing: userID))/\(key)/": post]
                            ref.updateChildValues(childUpdates)
                            print("done")
                            SVProgressHUD.showSuccess(withStatus: "Đã Upload")
                        }
                    }
                })
            })
        }
    }
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
    func imagecp() {
       
    }
    @IBAction func tr(_ sender: Any) {
        self.view.addSubview(select)
        select.center = self.view.center
        self.showAnimate()
    }
    @IBAction func agree(_ sender: Any) {
        loaidoan.titleLabel?.text = mon
        self.select.removeFromSuperview()
    }
    @IBAction func outviewtp(_ sender: Any) {
        self.select.removeFromSuperview()
    }
    func navibutton() {
        self.navigationItem.title = "Đăng bài"
        let btnCancel = UIButton()
        let btnUpload = UIButton()
        btnCancel.setImage(UIImage(named: "back"), for: .normal)
        btnUpload.setTitle("Đăng", for: .normal)
        btnUpload.setTitleColor(.black, for: .normal)
        btnCancel.addTarget(self, action:  #selector(gotohome), for: .touchUpInside)
        btnUpload.addTarget(self, action: #selector(uploadfile), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        let rightBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        rightBarButton.customView = btnUpload
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func gotohome(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gototabbar()
    }
    @objc func uploadfile(){
        SVProgressHUD.show(withStatus: "Loading...")
        let mota = textView.text
        let giatien = txtgiatien.text
        let diachi = txtdiachi.text
        let tenquan = txttenquan.text
        let loaimon = loaidoan.titleLabel?.text
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        guard let key = ref.child("location").child("2").childByAutoId().key else { return }
        var post = ["uid": userID!,
                    "mota": mota!,
                    "loaimon" : loaimon!,
                    "giatien": giatien!,
                    "diachi": diachi!,
                    "tenquan" : tenquan!] as [String: Any]
        let childRef = ref.child("TWEETS").child(userID!).childByAutoId()
        for i in PostViewController.imagecollection1 {
            let storageRef = Storage.storage().reference(forURL: "gs://appdocu-2c67f.appspot.com")
            let postRef = childRef.child("image")
            let autoID = postRef.childByAutoId().key
            let childStorageRef = storageRef.child("ImagePost").child(userID!).child(autoID!)
            let tweetImage = i
            if let uploadData = tweetImage.pngData() {
                childStorageRef.putData(uploadData, metadata: nil, completion: {
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
                                    let childUpdates = ["/post/\(key)": post,
                                                        "/user-posts/\(String(describing: userID))/\(key)/": post]
                                    ref.updateChildValues(childUpdates)
                                    SVProgressHUD.showSuccess(withStatus: "Đã Upload")
                                    let delegate = UIApplication.shared.delegate as! AppDelegate
                                    delegate.gototabbar()
                                }
                            }
                        })
                    }
                })
            }
        }
    }
    func alert(thongbao : String) {
        let alert = UIAlertController(title: "thong bao", message: thongbao, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action) in
            let loginviewcontroller = LoginViewController()
            self.navigationController?.pushViewController(loginviewcontroller, animated: true)
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
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
    func truyenmonan() {
        let db = Firestore.firestore()
        db.collection("loaimon").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dictionary = document.data()
                    let tenmon = dictionary["tenloaimon"] as! String
                    let image = dictionary["hinhanh"] as! String
                    let mangloaimon = loaimon(ten: tenmon, hinhanh: image)
                    self.loaimonve.append(mangloaimon)
                }
            }
            print(self.loaimonve)
            self.tableview.reloadData()
        }
    }
}
extension PostViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(loaimonve.count)
        return self.loaimonve.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "foodtableviewcell", for: indexPath) as! FoodTableViewCell
        cell.truyenve(loaimon1: loaimonve[indexPath.row])
        if self.selectedindex?.row == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0;
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Các loại món ăn"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoodTableViewCell
        mon = cell.tenmon.text ?? ""
        self.selectedindex = indexPath
        self.tableview.reloadData()
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
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let index = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
////        let a = index.anh.image
////        if let c = PostViewController.imagecollection1.firstIndex(of: a!){
////            print("tim thay \(c)")
////            PostViewController.imagecollection1.remove(at: c)
////        }
////        print(index)
////        print(PostViewController.imagecollection1)
////        collectionView.reloadData()
//    }
    
}
extension PostViewController : ParentControllerDelegate{
    func requestReloadTable() {
        self.collectionview.reloadData()
    }
    
}
extension PostViewController : UITextViewDelegate {
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
            textView.text = "Bạn mốn đăng gì?"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
