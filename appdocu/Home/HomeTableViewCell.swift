import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    var viewContro: HomeViewController?
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var post : UILabel!
    @IBOutlet weak var imageprofile : UIImageView!
    @IBOutlet weak var colletion: UICollectionView!
    var newFeed: NewFeedmodel1!
    

    func truyenve(Newfeed : NewFeedmodel1) {
        self.newFeed = Newfeed
        colletion.register(UINib(nibName: "HomeNewFeedCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "newfeedcollectionview")
        username.text = Newfeed.username
        post.text = Newfeed.mota
        if let profileimage = Newfeed.imageprofile {
            if let url = URL(string: profileimage){
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                    self.imageprofile.image = image
                }
            }
        }
        self.colletion.reloadData()
    }
}
extension HomeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newFeed.image.count > 3 ? 3 : self.newFeed.image.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newfeedcollectionview", for: indexPath) as! HomeNewFeedCollectionViewCell
        cell.truyenve(truyenim: self.newFeed.image[indexPath.row])
        if self.newFeed.image.count > 3 && indexPath.row == 2 {
            cell.blackView.isHidden = false
            cell.blackLabel.text = String(format: "+%d", self.newFeed.image.count - 3)
        } else {
            cell.blackView.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        transition.subtype = .fromBottom
        let homeImageDetails = HomeImageDetailsViewController()
        homeImageDetails.new = newFeed.image
        viewContro?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        homeImageDetails.hidesBottomBarWhenPushed = true
        viewContro?.navigationController?.pushViewController(homeImageDetails, animated: false)
    }
}
