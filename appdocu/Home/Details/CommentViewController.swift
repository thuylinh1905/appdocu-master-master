//
//  CommentViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/3/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var mota: UILabel!
    @IBOutlet weak var comment: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navibutton()
        self.title = "New Title";

        //For setting button in place of back button
//        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: "leftButtonClicked");
        let btnupload = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(uploadfile))
        self.navigationItem.leftBarButtonItem = btnupload
        // Do any additional setup after loading the view.
    }
    func navibutton() {
          self.navigationItem.title = "Đăng bài"
          let btnUpload = UIButton()
          btnUpload.setTitle("Đăng dcdsdss", for: .normal)
          btnUpload.addTarget(self, action: #selector(uploadfile), for: .touchUpInside)
          let rightBarButton = UIBarButtonItem()
          rightBarButton.customView = btnUpload
        self.navigationItem.rightBarButtonItem = rightBarButton
      }
      @objc func uploadfile(){
        print("dgsajgdaj")
      }
}
extension CommentViewController : UITextViewDelegate {
    func textview() {
        comment.text = "Tên công thức"
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
