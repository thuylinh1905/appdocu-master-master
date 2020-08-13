import UIKit
import FirebaseDatabase
import Kingfisher
import FirebaseStorage
import FirebaseAuth


struct imagebanner1 {
    var image : String!
    var image1 : String!
    init(image : String , image1 : String) {
        self.image = image
        self.image1 = image1
    }
}
struct menuhome {
    var image : String!
    init(image : String) {
        self.image = image
    }
}
class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionview : UICollectionView!
    var ref: DatabaseReference!
    var datahandle : DatabaseHandle!
    var arrNewfeed : [NewFeedModel] = []
    var array : [NewFeedmodel1] = []
    @IBOutlet weak var imagebanner : UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var mangima : [UIImage] = []
    var image01 : [String] = []
    @IBOutlet weak var anhtest: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationitem()
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "tableview")
        tableviewdata()
    }
    func tableviewdata() {
        let ref = Database.database().reference()
        ref.child("post").observe(.childAdded) { (snashot) in
            print(snashot)
            if let dic = snashot.value as? [String:Any] {
                let diachi = dic["diachi"] as! String
                let giatien = dic["giatien"] as! String
                let mota = dic["mota"] as! String
                let tenquan = dic["tenquan"] as! String
                let username = dic["username"] as! String
                let imageprofile = dic["Imageprofile"] as! String
                let image =  dic["image"] as! [String]
                print(image)
                let post1 = NewFeedmodel1(diachi: diachi, giatien: giatien, mota: mota, tenquan: tenquan, username: username, image: image, imageprofile: imageprofile)
                self.array.append(post1)
                print("hhshakhkash/\(self.array)")
                self.tableView.reloadData()
            }
        }
    }
    func navigationitem() {
        let butsearch = UIButton()
        butsearch.setImage(UIImage(named: "search"), for: .normal)
        butsearch.addTarget(self, action:  #selector(gotosearch), for: .touchUpInside)
        let leftBarButton1 = UIBarButtonItem()
        leftBarButton1.customView = butsearch
        
        self.navigationItem.rightBarButtonItem = leftBarButton1
        
        
        let butmess = UIButton()
        butmess.setImage(UIImage(named: "upload"), for: .normal)
        butmess.addTarget(self, action: #selector(upload), for: .touchUpInside)
        let leftbarbutton2 = UIBarButtonItem()
        leftbarbutton2.customView = butmess
        
        self.navigationItem.leftBarButtonItem = leftbarbutton2
    }
    @objc func gotosearch(){
    }
    @objc func upload(){
        let dellegate = UIApplication.shared.delegate as! AppDelegate
        dellegate.gotoupload()
    }
}
extension HomeViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableview", for: indexPath) as! HomeTableViewCell
        cell.truyenve(Newfeed: array[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
