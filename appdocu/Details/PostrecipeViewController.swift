//
//  PostrecipeViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/25/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class PostrecipeViewController: UIViewController {
    
    @IBOutlet var viewnguyenlieu: UIView!
    @IBOutlet var viewheader: UIView!
    @IBOutlet var viewfootersection: UIView!
    @IBOutlet weak var tenmon: UITextView!
    @IBOutlet weak var mota: UITextView!
    @IBOutlet weak var nguyenlieu: UITextView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var thoigiannau: UITextField!
    @IBOutlet weak var khauphan: UITextField!
    var names = [String]()
    var label : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableHeaderView = viewheader
//          viewheader.frame.size.height = 600
//        tenmon.sizeToFit()
//        mota.sizeToFit()
       
        viewheader.frame.size.height = 600
//        textfieldbuttomLine()
        textview()
//        tableview.register(UINib(nibName: "PostrecipeTableViewCell", bundle: .main), forCellReuseIdentifier: "postcell")
        kkkk()
    }
    func kkkk() {
         let c = tenmon.contentSize.height + mota.contentSize.height
         print(c)
    }
    @IBAction func addrow(_ sender: Any) {
        self.view.addSubview(viewnguyenlieu)
        viewnguyenlieu.center = self.view.center
        self.showAnimate()
    }
    @IBAction func dismissviewnguyenlieu(_ sender: Any) {
        self.viewnguyenlieu.removeFromSuperview()
        add(nguyenlieu: nguyenlieu.text)
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    func add(nguyenlieu : String) {
        let index = 0
        names.insert(nguyenlieu, at: index)
        let indexpath = IndexPath.init(row: index, section: 0)
        tableview.insertRows(at: [indexpath], with: .right)
    }
    @IBAction func removeRow(_ sender: Any) {
    }
    func textfieldbuttomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: khauphan.frame.height - 1, width: khauphan.frame.width, height: 0.5)
        bottomLine.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        khauphan.borderStyle = UITextField.BorderStyle.none
        khauphan.layer.addSublayer(bottomLine)
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: thoigiannau.frame.height - 1, width: thoigiannau.frame.width, height: 0.5)
        bottomLine1.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        thoigiannau.borderStyle = UITextField.BorderStyle.none
        thoigiannau.layer.addSublayer(bottomLine1)
    }
    func textview() {
        tenmon.text = "Tên món ăn"
        tenmon.textColor = UIColor.lightGray
        tenmon.translatesAutoresizingMaskIntoConstraints = false
        tenmon.isScrollEnabled = false
        tenmon.delegate = self
        tenmon.font = UIFont.systemFont(ofSize: 20)
//
//        mota.text = "Mô tả công thức"
//        mota.textColor = UIColor.lightGray
//        mota.translatesAutoresizingMaskIntoConstraints = false
//        mota.isScrollEnabled = false
//        mota.delegate = self
//        mota.font = UIFont.systemFont(ofSize: 20)
    }
}
extension PostrecipeViewController : UITextViewDelegate {
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
            
            textView.text = "Bạn mốn đăng gì?"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
extension PostrecipeViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostrecipeTableViewCell
        cell.name.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewfootersection
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
}
