import UIKit
import SDWebImage
import Kingfisher

class HomeDetailViewController: UIViewController {
    var NewFeedDetails : NewFeedDetail!
    
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var mota: UILabel!
    var mangimage : [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageprofile.layer.cornerRadius = 25
        truyenve()
    }
    func truyenve() {
        mota.text = NewFeedDetails.motacongthuc
        username.text = NewFeedDetails.username
        KingfisherManager.shared.retrieveImage(with: URL(string: NewFeedDetails.imageprofile)! as Resource, options: nil, progressBlock: nil) { (image, error, cache, url) in
            self.imageprofile.image = image
        }
    }
}
