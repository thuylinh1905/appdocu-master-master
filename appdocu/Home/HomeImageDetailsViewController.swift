import UIKit

class HomeImageDetailsViewController: UIViewController {

    @IBOutlet weak var imagecollection: UICollectionView!
    var new : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidenavi()
        imagecollection.delegate = self
        imagecollection.dataSource = self
        imagecollection.register(UINib(nibName: "ImageDetailsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imagecollection")
    }
}
extension HomeImageDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return new.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecollection", for: indexPath) as! ImageDetailsCollectionViewCell
        cell.truyenve(imagecell: new[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
