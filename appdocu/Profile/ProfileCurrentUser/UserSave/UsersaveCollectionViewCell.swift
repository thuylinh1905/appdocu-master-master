//
//  UsersaveCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/5/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth

class UsersaveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var user: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tencongthuc: UILabel!
    @IBOutlet weak var view: UIView!
    var delegate : ParentControllerDelegate?
    var NewFeed : NewFeedmodel1!
    var key : String!
    var usersavecontroller = UsersaveViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func truyenve(usersave : NewFeedmodel1) {
        self.NewFeed = usersave
        key = usersave.keyid
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.1
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        user.layer.cornerRadius = user.frame.size.width / 2
        tencongthuc.text = usersave.tencongthuc
        username.text = usersave.username
        user.sd_setImage(with: URL(string: usersave.imageprofile))
        let first5 = usersave.image.prefix(1)
        for i in first5 {
            image.sd_setImage(with: URL(string: i))
        }
    }
    @IBAction func deletecell(_ sender: Any) {
        let alert = UIAlertController(title: "Thông Báo", message: "Bạn có chắc muốn xóa bài ", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action) in
            let userid = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            let deleteref = ref.child("Save-User").child(userid!).child(self.key)
            deleteref.removeValue()
            if let keyid = UsersaveViewController.usersave.firstIndex(where: { $0.keyid == self.key }){
                UsersaveViewController.usersave.remove(at: keyid)
            }
            self.delegate?.requestReloadTable()
        }
        let action2 = UIAlertAction(title: "Hủy bỏ", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
