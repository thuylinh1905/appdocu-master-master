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
    @IBOutlet weak var searchbar: UISearchBar!
    var array1 : [NewFeedmodel1] = []
    var array2 : [NewFeedmodel1] = []
    var searcharray : [NewFeedmodel1] = []
    var searching = false
    var searchtext : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "SearchTableViewCell", bundle: .main), forCellReuseIdentifier: "search")
        searchbar.text = searchtext
        find()
        searchbar.delegate = self
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
        cell.view.layer.cornerRadius = 5
        cell.view.layer.masksToBounds = true
        cell.view.layer.borderWidth = 0.2
        cell.view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    func find() {
         let searchText = searchbar.text
         searcharray = array1.filter({return $0.tencongthuc.lowercased().contains(searchText!.lowercased())})
         searching = searcharray.count > 0
//        self.tableview.reloadData()
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
        let NewFeed = NewFeedDetail(tencongthuc: tencongthuc, motacongthuc: motacongthuc, khauphan: khauphan, thoigiannau: thoigiannau, username: username, image: image, imageprofile: imageprofile!, nguyenlieu: nguyenlieu!, congthuc: congthuc!, keyid: keyid)
        let homeDetailViewcontroller = HomeDetailsViewController()
        homeDetailViewcontroller.NewFeedDetails = NewFeed
        homeDetailViewcontroller.NewFeed = array1
        homeDetailViewcontroller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeDetailViewcontroller , animated: true)
    }
}
extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text

        searcharray = array1.filter({return $0.tencongthuc.lowercased().contains(searchText!.lowercased())})

        searching = searcharray.count > 0
        self.tableview.reloadData()
    }
}
