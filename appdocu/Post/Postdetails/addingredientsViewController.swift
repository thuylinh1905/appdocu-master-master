//
//  addingredientsViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/30/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

struct tablechooose {
    var tenheader : String!
    var name : [String]
    init(name : [String]) {
        self.name = name
    }
}

class addingredientsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
   
    @IBOutlet var tablenguyenlieuheader: UIView!
    @IBOutlet var select: UIView!
    @IBOutlet weak var nguyenlieutext: UITextView!
    @IBOutlet weak var tableviewnguyenlieu: UITableView!
    var nguyenlieu = [String]()
    var congthuc = [String]()
    var index = 0
    var tablechooose1 = [tablechooose]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewnguyenlieu.tableHeaderView = tablenguyenlieuheader
       tableviewnguyenlieu.register(UINib(nibName: "ingredientsTableViewCell", bundle: .main), forCellReuseIdentifier: "ingredientscell")
        tableviewnguyenlieu.register(UINib(nibName: "CookingTableViewCell", bundle: .main), forCellReuseIdentifier: "cookingcell")
        congthuc = ["mot", "hai" , "ba"]
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        switch section {
//        case 0:
//            return nguyenlieu.count
//        case 1:
//            return congthuc.count
//        default:
//            return 0
//        }
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 1 {
//            return self.nguyenlieu.count
//        } else {
//            return self.congthuc.count
//        }
        
        if section == 0 {
            return self.nguyenlieu.count
        } else {
            return self.congthuc.count
        }
//        return self.nguyenlieu.count + self.congthuc.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row < nguyenlieu.count{
//           let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
//           cell.txtnguyenlieu.text = nguyenlieu[indexPath.row]
//           return cell
//        } else {
//            let cell = tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
//            cell.txtcongthuc.text = congthuc[indexPath.row]
//            return cell
//        }
        if indexPath.section == 0 {
            let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
            cell.txtnguyenlieu.text = nguyenlieu[indexPath.row]
            return cell
        } else {
            let cell = tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
            cell.txtcongthuc.text = congthuc[indexPath.row]
            return cell
        }
//        switch indexPath.section {
//        case 0:
//            let cell = self.tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "ingredientscell", for: indexPath) as! ingredientsTableViewCell
//                      cell.txtnguyenlieu.text = nguyenlieu[indexPath.row]
//                      return cell
//        case 1:
//           let cell = tableviewnguyenlieu.dequeueReusableCell(withIdentifier: "cookingcell", for: indexPath) as! CookingTableViewCell
//            cell.txtcongthuc.text = congthuc[indexPath.row]
//            return cell
//        default:
//            return UITableViewCell()
//        }
       }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return tablenguyenlieuheader
//    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "nguyen liêu"
        } else {
            return "cong thức"
        }
       }
       func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
               let ob = nguyenlieu[sourceIndexPath.row]
               nguyenlieu.remove(at: sourceIndexPath.row)
               nguyenlieu.insert(ob, at: destinationIndexPath.item)
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
              nguyenlieu.insert(nguyenlieutext, at: index)
              let indexpath = IndexPath.init(row: index, section: 0)
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
