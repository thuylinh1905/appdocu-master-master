//
//  addingredientsViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/30/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import DKImagePickerController

class addingredientsViewController: UIViewController {
    
    @IBOutlet weak var txtkhauphan: UITextField!
    @IBOutlet weak var txtthoigiannau: UITextField!
    @IBOutlet var tablenguyenlieuheader: UIView!
    @IBOutlet var select: UIView!
    @IBOutlet weak var nguyenlieutext: UITextView!
    @IBOutlet weak var tableviewnguyenlieu: UITableView!
    @IBOutlet var tablecongthucheader: UIView!
    @IBOutlet weak var collectionimage: UICollectionView!
    @IBOutlet var viewcongthuc: UIView!
    @IBOutlet weak var congthuctext: UITextView!
    static var nguyenlieu = [String]()
    static var congthuc = [String]()
    var index = 0
    var imagecollectioncell : [UIImage]! = []
    var imagecollection1cell : [UIImage]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewnguyenlieu.register(UINib(nibName: "ingredientsTableViewCell", bundle: .main), forCellReuseIdentifier: "ingredientscell")
        tableviewnguyenlieu.register(UINib(nibName: "CookingTableViewCell", bundle: .main), forCellReuseIdentifier: "cookingcell")
        navigationitem()
        textview()
    }
}
extension addingredientsViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return addingredientsViewController.self.nguyenlieu.count
        } else {
            return addingredientsViewController.self.congthuc.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
            cell.txtnguyenlieu.text = addingredientsViewController.nguyenlieu[indexPath.row]
            return cell
        } else {
            let cell = tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
            cell.txtcongthuc.text = addingredientsViewController.congthuc[indexPath.row]
            cell.number.text = String(indexPath.row)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Nguyên Liệu"
        }
        return "Các bước thực hiện"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = .black
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return tablenguyenlieuheader
        }
        return tablecongthucheader
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
                addingredientsViewController.nguyenlieu.remove(at: indexPath.item)
                tableviewnguyenlieu.deleteRows(at: [indexPath], with: .automatic)
            }
        } else {
            if editingStyle == .delete {
                addingredientsViewController.congthuc.remove(at: indexPath.item)
                tableviewnguyenlieu.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if destinationIndexPath.section  == 0 {
            let ob = addingredientsViewController.nguyenlieu[sourceIndexPath.row]
            addingredientsViewController.nguyenlieu.remove(at: sourceIndexPath.row)
            addingredientsViewController.nguyenlieu.insert(ob, at: destinationIndexPath.item)
        }
        let ob1 = addingredientsViewController.congthuc[sourceIndexPath.row]
        addingredientsViewController.congthuc.remove(at: sourceIndexPath.row)
        addingredientsViewController.congthuc.insert(ob1, at: destinationIndexPath.item)
    }
    
}

extension addingredientsViewController {
    func navigationitem() {
        let butsearch = UIButton()
        butsearch.setTitle("Ok", for: .normal)
        butsearch.addTarget(self, action:  #selector(poptopostview), for: .touchUpInside)
        let leftBarButton1 = UIBarButtonItem()
        leftBarButton1.customView = butsearch
        
        self.navigationItem.rightBarButtonItem = leftBarButton1
    }
    @objc func poptopostview() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func deletenguyenlieu(_ sender: UIBarButtonItem) {
        self.tableviewnguyenlieu.isEditing = !self.tableviewnguyenlieu.isEditing
        sender.title = (self.tableviewnguyenlieu.isEditing) ? "Done" : "Edit"
    }
    @IBAction func deletecongthuc(_ sender: UIBarButtonItem) {
        self.tableviewnguyenlieu.isEditing = !self.tableviewnguyenlieu.isEditing
        sender.title = (self.tableviewnguyenlieu.isEditing) ? "Done" : "Edit"
    }
    @IBAction func addnguyenlieu(_ sender: Any) {
        self.view.addSubview(select)
        showAnimate()
    }
    @IBAction func agree(_ sender: Any) {
        self.select.removeFromSuperview()
        addnguyenieu(nguyenlieu: nguyenlieutext.text)
        nguyenlieutext.text = ""
    }
    @IBAction func removesubview(_ sender: Any) {
        self.select.removeFromSuperview()
    }
    func addnguyenieu(nguyenlieu : String) {
        addingredientsViewController.nguyenlieu.append(nguyenlieu)
        self.tableviewnguyenlieu.reloadData()
    }
    @IBAction func addcongthuc(_ sender: Any) {
       let addrow = addRowViewController()
        addrow.delegate = self
        self.present(UINavigationController(rootViewController: addrow), animated: true, completion: nil)
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.2;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.select.translatesAutoresizingMaskIntoConstraints = false
            self.select.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.select.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.select.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 50 / 2).isActive = true
            self.select.heightAnchor.constraint(equalToConstant: 500).isActive = true
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
}
extension addingredientsViewController : UITextViewDelegate {
    func textview() {
        nguyenlieutext.text = "Placeholder for UITextView"
        nguyenlieutext.textColor = UIColor.lightGray
        nguyenlieutext.font = UIFont(name: "verdana", size: 13.0)
        nguyenlieutext.returnKeyType = .done
        nguyenlieutext.delegate = self
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == "Placeholder for UITextView" {
               textView.text = ""
               textView.textColor = UIColor.black
               textView.font = UIFont(name: "verdana", size: 18.0)
           }
       }
       
       func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if text == "\n" {
               textView.resignFirstResponder()
           }
           return true
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text == "" {
               textView.text = "Placeholder for UITextView"
               textView.textColor = UIColor.lightGray
               textView.font = UIFont(name: "verdana", size: 13.0)
           }
       }
}
extension addingredientsViewController : addrowcongthuc {
    func addrow(congthuc: String) {
        self.dismiss(animated: true, completion: nil)
        addingredientsViewController.congthuc.append(congthuc)
        self.tableviewnguyenlieu.reloadData()
    }
}
