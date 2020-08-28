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
    
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ts: UIImageView!
    
    @IBOutlet weak var txtmota: UITextField!
    @IBOutlet weak var txttenquan: UITextField!
    @IBOutlet weak var txtdiachi: UITextField!
    @IBOutlet weak var txtgiatien: UITextField!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var loaidoan: UIButton!
    
    
    @IBOutlet var tablenguyenlieuheader: UIView!
    @IBOutlet var tablecongthucheader: UIView!
    @IBOutlet var select: UIView!
    @IBOutlet var viewcongthuc: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tencongthuc: UITextView!
    @IBOutlet weak var motacongthuc : UITextView!
    @IBOutlet weak var nguyenlieutext: UITextView!
    @IBOutlet weak var congthuctext: UITextView!
    @IBOutlet weak var txtkhauphan: UITextField!
    @IBOutlet weak var txtthoigiannau: UITextField!
    @IBOutlet weak var tableviewnguyenlieu: UITableView!
    @IBOutlet weak var tableviewcongthuc: UITableView!
    var mon = ""
    var selectedindex : IndexPath?
    var imagecollection : [UIImage]! = []
    static var imagecollection1 : [UIImage]! = []
    var updateimage : [String] = []
    var assets = [DKAsset]()
    var nguyenlieu = [String]()
    var congthuc = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        collectionview.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "collection")
        tableviewnguyenlieu.register(UINib(nibName: "ingredientsTableViewCell", bundle: .main), forCellReuseIdentifier: "ingredientscell")
        tableviewcongthuc.register(UINib(nibName: "CookingTableViewCell", bundle: .main), forCellReuseIdentifier: "cookingcell")
        //        view.openCamera(moanh)
        //        self.textView.inputAccessoryView = view
        self.hideKeyboard()
        collectionview.delegate =  self
        collectionview.dataSource = self
        tableviewnguyenlieu.delegate = self
        tableviewnguyenlieu.dataSource = self
        tableviewcongthuc.delegate = self
        tableviewcongthuc.dataSource = self
        textview()
        textfieldbuttomLine()
    }
    
    
}
extension PostViewController {
    @IBAction func addnguyenlieu(_ sender: Any) {
        self.view.addSubview(select)
        select.center = self.view.center
        self.showAnimate()
    }
    @IBAction func agree(_ sender: Any) {
        self.select.removeFromSuperview()
        add(nguyenlieutext: nguyenlieutext.text)
    }
    @IBAction func outviewtp(_ sender: Any) {
        self.select.removeFromSuperview()
    }
    func add(nguyenlieutext : String) {
        nguyenlieu.insert(nguyenlieutext, at: index)
        let indexpath = IndexPath.init(row: index, section: 0)
        tableviewnguyenlieu.insertRows(at: [indexpath], with: .right)
    }
    @IBAction func addcongthuc(_ sender: Any) {
        self.view.addSubview(viewcongthuc)
        viewcongthuc.center = self.view.center
        self.showAnimate()
    }
    @IBAction func outview(_ sender: Any) {
        self.viewcongthuc.removeFromSuperview()
    }
    @IBAction func agreecongthuc(_ sender: Any) {
        self.viewcongthuc.removeFromSuperview()
        addcongthu(congthuctext: congthuctext.text)
    }
    func addcongthu(congthuctext : String) {
        congthuc.insert(congthuctext, at: index)
        let indexpath = IndexPath.init(row: index, section: 0)
        tableviewcongthuc.insertRows(at: [indexpath], with: .right)
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
    //    func truyenmonan() {
    //          let db = Firestore.firestore()
    //          db.collection("loaimon").getDocuments() { (querySnapshot, err) in
    //              if let err = err {
    //                  print("Error getting documents: \(err)")
    //              } else {
    //                  for document in querySnapshot!.documents {
    //                      let dictionary = document.data()
    //                      let tenmon = dictionary["tenloaimon"] as! String
    //                      let image = dictionary["hinhanh"] as! String
    //                      let mangloaimon = loaimon(ten: tenmon, hinhanh: image)
    //                      self.loaimonve.append(mangloaimon)
    //                  }
    //              }
    //              print(self.loaimonve)
    //              self.tableview.reloadData()
    //          }
    //      }
}
extension PostViewController {
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
    func alert(thongbao : String) {
        let alert = UIAlertController(title: "thong bao", message: thongbao, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action) in
            let loginviewcontroller = LoginViewController()
            self.navigationController?.pushViewController(loginviewcontroller, animated: true)
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension PostViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberofRow : Int!
        switch tableView {
        case tableviewnguyenlieu :
            numberofRow = self.nguyenlieu.count
        case tableviewcongthuc :
            numberofRow = self.congthuc.count
        default:
            print("loi roi")
        }
        return numberofRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableviewnguyenlieu {
            let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
            cell.txtnguyenlieu.text = nguyenlieu[indexPath.row]
            return cell
        } else {
            let cell = tableviewcongthuc.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
            cell.txtcongthuc.text = congthuc[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view = UIView()
        switch tableView {
        case tableviewnguyenlieu :
            view = tablenguyenlieuheader
        case tableviewcongthuc :
            view = tablecongthucheader
        default:
            print("loi roi")
        }
        return view
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title : String = ""
        switch tableView {
        case tableviewnguyenlieu :
            title = "Các loại nguyên liệu"
        case tableviewcongthuc :
            title =  "Cách làm"
        default:
            print("loi roi")
        }
        return title
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
    @IBAction func hihi(_ sender: Any) {
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
                    "nguyenlieu" : nguyenlieu,
                    "congthucnau" : congthuc] as [String: Any]
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
                                                        "/user-NewPeedPost/\(String(describing: userID))/\(key)/": post]
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
    @objc func uploadfile(){
        SVProgressHUD.show(withStatus: "Loading...")
        let mota = tencongthuc.text
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
                                    //                                           SVProgressHUD.showSuccess(withStatus: "Đã Upload")
                                    //                                           let delegate = UIApplication.shared.delegate as! AppDelegate
                                    //                                           delegate.gototabbar()
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
