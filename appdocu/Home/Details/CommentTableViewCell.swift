//
//  CommentTableViewCell.swift
//  appdocu
//
//  Created by thuylinh on 8/30/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var comment: UILabel!
    
    func truyenve(commentuser : UserComment) {
        comment.text = commentuser.comment
        username.text = commentuser.username
        imageprofile.sd_setImage(with: URL(string: commentuser.image), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
