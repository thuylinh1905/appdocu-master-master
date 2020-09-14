//
//  UserfoodCollectionViewCell.swift
//  appdocu
//
//  Created by thuylinh on 9/9/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase

class UserfoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageuser: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var view: UIView!
    var key: String!
    var delegate : ParentControllerDelegate?
    var newFeed: NewFeedmodel1!
    
    func truyen(Newfeed : NewFeedmodel1) {
        key = Newfeed.keyid
        self.newFeed = Newfeed
        username.text = Newfeed.username
        text.text = Newfeed.tencongthuc
        imageuser.sd_setImage(with: URL(string: Newfeed.imageprofile))
        imageuser.layer.cornerRadius = 10
        let first5 = Newfeed.image.prefix(1)
        for i in first5 {
            image.sd_setImage(with: URL(string: i))
        }
    }
    
    @IBAction func more(_ sender: Any) {
           let userid = Auth.auth().currentUser?.uid
             let ref = Database.database().reference()
             let deleteref = ref.child("user-NewPeedPost").child(userid!).child(key)
             let deleteref1 = ref.child("NewPeedPost").child(self.key)
             deleteref.removeValue()
             deleteref1.removeValue()
        if let keyid = UserfooodViewController.array.firstIndex(where: { $0.keyid == key }){
                 UserfooodViewController.array.remove(at: keyid)
             }
             delegate?.requestReloadTable()
    }
}
