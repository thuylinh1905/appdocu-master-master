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
    
    @IBOutlet var nguyenlieufooter: UIView!
    @IBOutlet var congthucfooter: UIView!
    @IBOutlet var tableviewheader: UIView!
    @IBOutlet weak var textheader : UILabel!
    @IBOutlet weak var tableviewnguyenlieu: UITableView!
    static var nguyenlieu = [String]()
    static var congthuc = [String]()
    var index = 0
    var imagecollectioncell : [UIImage]! = []
    var imagecollection1cell : [UIImage]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingredientsViewController.nguyenlieu.append("nhap nguyen lieu")
        addingredientsViewController.congthuc.append("nhap cong thuc")
        tableviewnguyenlieu.register(UINib(nibName: "ingredientsTableViewCell", bundle: .main), forCellReuseIdentifier: "ingredientscell")
        tableviewnguyenlieu.register(UINib(nibName: "CookingTableViewCell", bundle: .main), forCellReuseIdentifier: "cookingcell")
        navigationbar()
        tableviewnguyenlieu.rowHeight = UITableView.automaticDimension
        tableviewnguyenlieu.rowHeight = 100
        textview()
    }
}
extension addingredientsViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return addingredientsViewController.nguyenlieu.count
        } else {
            return addingredientsViewController.congthuc.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row < addingredientsViewController.nguyenlieu.count {
                let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
                cell.rowindex = indexPath.row
                cell.txtnguyenlieu.text = addingredientsViewController.nguyenlieu[indexPath.row]
                cell.delegate = self
                return cell
            } else {
                let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
                return cell
            }
        } else {
            if indexPath.row < addingredientsViewController.congthuc.count {
                let cell = tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
                cell.txtcongthuc.text = addingredientsViewController.congthuc[indexPath.row]
                cell.number.text = String(indexPath.row)
                cell.delegate = self
                cell.rowindex = indexPath.row
                return cell
            } else {
                let cell = tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
                return cell
            }
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
            return nguyenlieufooter
        }
        return congthucfooter
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension addingredientsViewController : ParentControllerDelegate{
    func navigationbar() {
        let backbutton = UIButton()
        backbutton.setImage(UIImage(named: "back"), for: .normal)
        backbutton.setTitle("Công thức", for: .normal)
        backbutton.addTarget(self, action: #selector(popview), for: .touchUpInside)
        let leftbuttonitem = UIBarButtonItem()
        leftbuttonitem.customView = backbutton
        self.navigationItem.leftBarButtonItem = leftbuttonitem
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
    }
    @objc func popview(){
        self.navigationController?.popViewController(animated: true)
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
        self.view.endEditing(true)
        var allTextViewsText = ""
        for i in 0...addingredientsViewController.nguyenlieu.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableviewnguyenlieu.cellForRow(at: indexPath) as? ingredientsTableViewCell {
                allTextViewsText = cell.txtnguyenlieu.text
            }
        }
        addingredientsViewController.nguyenlieu.append("nhap nguyen lieu")
        self.tableviewnguyenlieu.reloadData()
        print(addingredientsViewController.nguyenlieu)
    }
    @IBAction func addcongthuc(_ sender: Any) {
        self.view.endEditing(true)
        var textviewconthuc = ""
        for i in 0...addingredientsViewController.congthuc.count{
            let indexPath = IndexPath(row: i, section: 1)
            if let cell = tableviewnguyenlieu.cellForRow(at: indexPath) as? CookingTableViewCell {
                textviewconthuc = cell.txtcongthuc.text
            }
        }
        addingredientsViewController.congthuc.append("nhap cong thuc")
        self.tableviewnguyenlieu.reloadData()
        print(addingredientsViewController.congthuc)
    }
    func requestReloadTable() {
        self.tableviewnguyenlieu.reloadData()
    }
}
extension addingredientsViewController : UITextViewDelegate {
    func textview() {
        //        nguyenlieutext.text = "Placeholder for UITextView"
        //        nguyenlieutext.textColor = UIColor.lightGray
        //        nguyenlieutext.font = UIFont(name: "verdana", size: 13.0)
        //        nguyenlieutext.returnKeyType = .done
        //        nguyenlieutext.delegate = self
    }
    func textViewDidChange(_ textView: UITextView) {
        tableviewnguyenlieu.beginUpdates()
        tableviewnguyenlieu.endUpdates()
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
