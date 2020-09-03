import UIKit
import FirebaseDatabase
import Kingfisher
import FirebaseStorage
import FirebaseAuth

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "tableview")
//        tableView.rowHeight = UITableView.automaticDimension
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
                let keyid = dic["keyid"] as! String
                let post1 = NewFeedmodel1(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile, nguyenlieu: nguyenlieu, congthuc: congthuc, keyid: keyid)
                self.array.append(post1)
                self.tableView.reloadData()
            }
        }
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
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
        let keyid = cell.newFeed.keyid
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
