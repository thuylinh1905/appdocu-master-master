//
//  SearchViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/6/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var array1 : [NewFeedmodel1] = []
    var array2 : [NewFeedmodel1] = []
    var searcharray : [NewFeedmodel1] = []
    var searching = false
    var searchtext : String!
    let searchbar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "SearchTableViewCell", bundle: .main), forCellReuseIdentifier: "search")
        self.navigationItem.titleView = searchbar
        searchbar.text = searchtext
        find()
        searchbar.delegate = self
        navigationbar()
        searchbackground()
    }
}
extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searcharray.count
        } else {
            return array1.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchTableViewCell
        if searching {
            cell.truyenve(newfeed: searcharray[indexPath.row])
        } else {
            cell.truyenve(newfeed: array1[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath) as! SearchTableViewCell
        let tencongthuc = cell.celldetails.tencongthuc
        let motacongthuc = cell.celldetails.motacongthuc
        let khauphan = cell.celldetails.khauphan
        let thoigiannau = cell.celldetails.thoigiannau
        let username = cell.celldetails.username!
        let image = cell.celldetails.image!
        let imageprofile = cell.celldetails.imageprofile
        let nguyenlieu = cell.celldetails.nguyenlieu
        let congthuc = cell.celldetails.congthuc
        let keyid = cell.celldetails.keyid
        let like = cell.celldetails.like
        let uid = cell.celldetails.uid
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid , like : like , uid:  uid)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.NewFeed = array1
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
extension SearchViewController : UISearchBarDelegate {
    func navigationbar() {
        let backbutton = UIButton()
        backbutton.setImage(UIImage(named: "back"), for: .normal)
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
    func find() {
        let searchText = searchbar.text
        searcharray = array1.filter({return $0.tencongthuc.lowercased().contains(searchText!.lowercased())})
        searching = searcharray.count > 0
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text
        
        searcharray = array1.filter({return $0.tencongthuc.lowercased().contains(searchText!.lowercased())})
        
        searching = searcharray.count > 0
        self.tableview.reloadData()
    }
    func searchbackground() {
        if #available(iOS 13.0, *) {
            searchbar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            searchbar.searchTextField.tintColor = .black
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            searchbar.searchTextField.textColor = .black
        } else {
            // Fallback on earlier versions
        }
    }
}
