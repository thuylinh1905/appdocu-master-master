import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    var viewContro: HomeViewController?
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var tencongthuc : UILabel!
    @IBOutlet weak var motacongthuc: UILabel!
    @IBOutlet weak var imageprofile : UIImageView!
    @IBOutlet weak var colletion: UICollectionView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    var newFeed: NewFeedmodel1!
    var counter = 0
    var timer = Timer()

    func truyenve(Newfeed : NewFeedmodel1) {
        print(Newfeed.image.count)
        self.newFeed = Newfeed
        colletion.register(UINib(nibName: "HomeNewFeedCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "newfeedcollectionview")
        username.text = Newfeed.username
        tencongthuc.text = Newfeed.tencongthuc
        motacongthuc.text = Newfeed.motacongthuc
        if let profileimage = Newfeed.imageprofile {
            if let url = URL(string: profileimage){
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                    self.imageprofile.image = image
                }
            }
        }
        self.pagecontrol.numberOfPages = Newfeed.image.count
        self.colletion.delegate = self
        self.colletion.dataSource = self
        self.colletion.reloadData()
    }
}
extension HomeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = colletion.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.newFeed.image.count > 3 ? 3 : self.newFeed.image.count
        return self.newFeed.image.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newfeedcollectionview", for: indexPath) as! HomeNewFeedCollectionViewCell
        cell.truyenve(truyenim: self.newFeed.image[indexPath.row])
//        if self.newFeed.image.count > 3 && indexPath.row == 2 {
//            cell.blackView.isHidden = false
//            cell.blackLabel.text = String(format: "+%d", self.newFeed.image.count - 3)
//        } else {
//            cell.blackView.isHidden = true
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pagecontrol?.currentPage = Int(roundedIndex)
    }
}
