//
//  CommentViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/3/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

protocol comment {
    func commnetuser (commenttext : String)
}

class CommentViewController: UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var mota: UILabel!
    @IBOutlet weak var comment: UITextView!
    var delegate : comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        textview()
    }
    func navibutton() {
        self.navigationItem.title = "Thêm Bình Luận"
        let btnUpload = UIButton()
        btnUpload.setImage(UIImage(named: "send"), for: .normal)
        btnUpload.addTarget(self, action: #selector(uploadfile), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(exit))
        rightBarButton.customView = btnUpload
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func exit(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func uploadfile(){
        delegate?.commnetuser(commenttext: comment.text)
    }
   
}
extension CommentViewController : UITextViewDelegate {
    func textview() {
        comment.text = "Vui lòng nhập bình luận của bạn..."
        comment.textColor = UIColor.lightGray
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.isScrollEnabled = false
        comment.delegate = self
        comment.font = UIFont.systemFont(ofSize: 20)
    }
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint ) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
        }
    }
    
}
