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
        ref.child("post").observe(.childAdded) { (snashot) in
            if let dic = snashot.value as? [String:Any] {
                let diachi = dic["diachi"] as! String
                let giatien = dic["giatien"] as! String
                let mota = dic["mota"] as! String
                let tenquan = dic["tenquan"] as! String
                let username = dic["username"] as! String
                let imageprofile = dic["Imageprofile"] as! String
                let image =  dic["image"] as! [String]
                let post1 = NewFeedmodel1(diachi: diachi, giatien: giatien, mota: mota, tenquan: tenquan, username: username, image: image, imageprofile: imageprofile)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        let mota = cell.newFeed.mota
        let diachi = cell.newFeed.diachi
        let giatien = cell.newFeed.giatien
        let tenquan = cell.newFeed.tenquan
        let username = cell.newFeed.username!
        let image = cell.newFeed.image!
        let imageprofile = cell.newFeed.imageprofile
        let NewFeed = NewFeedDetail(diachi: diachi, giatien: giatien, mota: mota, tenquan: tenquan, username: username, image: image, imageprofile: imageprofile!)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
//        let deleget = UIApplication.shared.delegate as! AppDelegate
//        deleget.gototabbar1()
    }
}
