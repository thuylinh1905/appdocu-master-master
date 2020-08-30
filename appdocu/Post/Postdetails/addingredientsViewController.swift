//
//  addingredientsViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/30/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit


class addingredientsViewController: UIViewController {
   
    @IBOutlet var tablenguyenlieuheader: UIView!
    @IBOutlet var select: UIView!
    @IBOutlet weak var nguyenlieutext: UITextView!
    @IBOutlet weak var tableviewnguyenlieu: UITableView!
    @IBOutlet var tablecongthucheader: UIView!
    @IBOutlet var viewcongthuc: UIView!
    @IBOutlet weak var congthuctext: UITextView!
    static var nguyenlieu = [String]()
    static var congthuc = [String]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableviewnguyenlieu.register(UINib(nibName: "ingredientsTableViewCell", bundle: .main), forCellReuseIdentifier: "ingredientscell")
       tableviewnguyenlieu.register(UINib(nibName: "CookingTableViewCell", bundle: .main), forCellReuseIdentifier: "cookingcell")
        navigationitem()
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
              select.center = self.view.center
              self.showAnimate()
          }
          @IBAction func agree(_ sender: Any) {
              self.select.removeFromSuperview()
              add(nguyenlieutext: nguyenlieutext.text)
          }
          @IBAction func outviewtp(_ sender: Any) {
              self.select.removeFromSuperview()
          }
          func add(nguyenlieutext : String) {
            addingredientsViewController.nguyenlieu.insert(nguyenlieutext, at: index)
              let indexpath = IndexPath.init(row: index, section: 0)
              tableviewnguyenlieu.insertRows(at: [indexpath], with: .right)
          }
    @IBAction func addcongthuc(_ sender: Any) {
        self.view.addSubview(viewcongthuc)
        viewcongthuc.center = self.view.center
        self.showAnimate()
    }
    @IBAction func outview(_ sender: Any) {
        self.viewcongthuc.removeFromSuperview()
    }
    @IBAction func agreecongthuc(_ sender: Any) {
        self.viewcongthuc.removeFromSuperview()
        addcongthu(congthuctext: congthuctext.text)
    }
    func addcongthu(congthuctext : String) {
        addingredientsViewController.congthuc.insert(congthuctext, at: index)
        let indexpath = IndexPath.init(row: index, section: 1)
        tableviewnguyenlieu.insertRows(at: [indexpath], with: .right)
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
}
