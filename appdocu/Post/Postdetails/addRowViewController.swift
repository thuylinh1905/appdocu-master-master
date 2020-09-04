//
//  addRowViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/4/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

protocol addRowcongthuc{
    func addrow(congthuc : String)
}


class addRowViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    var delegate: addrowcongthuc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        
        // Do any additional setup after loading the view.
    }
    func navibutton() {
        self.navigationItem.title = "Đăng bài"
        let btnCancel = UIButton()
        let btnUpload = UIButton()
        btnCancel.setImage(UIImage(named: "back"), for: .normal)
        btnUpload.setTitle("Đăng", for: .normal)
        btnUpload.setTitleColor(.black, for: .normal)
        btnCancel.addTarget(self, action:  #selector(gotohome), for: .touchUpInside)
        btnUpload.addTarget(self, action: #selector(uploadfile), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        let rightBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        rightBarButton.customView = btnUpload
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func gotohome(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gototabbar()
    }
    @objc func uploadfile(){
        delegate?.addrow(congthuc: textview.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
