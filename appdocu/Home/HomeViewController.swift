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
    @IBOutlet weak var imagezoom: UIImageView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.tabBarController?.tabBar.isHidden = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationitem()
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "tableview")
        tableView.rowHeight = UITableView.automaticDimension
        tableviewdata()
    }
    func tableviewdata() {
        let ref = Database.database().reference()
        ref.child("NewPeedPost").observe(.childAdded) { (snashot) in
            if let dic = snashot.value as? [String:Any] {
                let tencongthuc = dic["tencongthuc"] as! String
                let motacongthuc = dic["motacongthuc"] as! String
                let khauphan = dic["khauphan"] as! String
                let thoigiannau = dic["thoigiannau"] as! String
                let nguyenlieu = dic["nguyenlieu"] as! [String]
                let congthuc = dic["congthucnau"] as! [String]
                let username = dic["username"] as! String
                let imageprofile = dic["Imageprofile"] as! String
                let image =  dic["image"] as! [String]
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc)
                self.array.append(post1)
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
        let post = PostrecipeViewController()
        self.navigationController?.pushViewController(post, animated: true)
    }
}
extension HomeViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableview", for: indexPath) as! HomeTableViewCell
        cell.truyenve(Newfeed: array[indexPath.row])
        cell.viewContro = self
        return cell
    }
//    let tencongthuc = dic["tencongthuc"] as! String
//                   let motacongthuc = dic["motacongthuc"] as! String
//                   let khauphan = dic["khauphan"] as! String
//                   let thoigiannau = dic["thoigiannau"] as! String
//                   let nguyenlieu = dic["nguyenlieu"] as! [String]
//                   let congthuc = dic["congthucnau"] as! [String]
//                   let username = dic["username"] as! String
//                   let imageprofile = dic["Imageprofile"] as! String
//                   let image =  dic["image"] as! [String]
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let motacongthuc = cell.newFeed.motacongthuc
        let khauphan = cell.newFeed.khauphan
        let thoigiannau = cell.newFeed.thoigiannau
        let tencongthuc = cell.newFeed.tencongthuc
        let nguyenlieu = cell.newFeed.nguyenlieu
        let congthuc = cell.newFeed.congthuc
        let username = cell.newFeed.username!
        let image = cell.newFeed.image!
        let imageprofile = cell.newFeed.imageprofile
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
