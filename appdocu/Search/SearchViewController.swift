//
//  SearchViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/6/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var searcharray : [NewFeedmodel1] = []
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "SearchTableViewCell", bundle: .main), forCellReuseIdentifier: "search")
        searchbar.text = "6"
        find()
          searchbar.delegate = self
    }
}
extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searcharray.count
        } else {
            return HomeViewController.array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchTableViewCell
        if searching {
            cell.truyenve(newfeed: searcharray[indexPath.row])
        } else {
            cell.truyenve(newfeed: HomeViewController.array[indexPath.row])
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
         searcharray = HomeViewController.array.filter({
                   return $0.tencongthuc.lowercased().contains(searchText!.lowercased())
               })
         searching = searcharray.count > 0
        self.tableview.reloadData()
    }
}
extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searcharray = HomeViewController.array.filter({$0.tencongthuc.prefix(searchText.count) == searchBar.text})
//        searching = true
//        tableview.reloadData()
        let searchText = searchBar.text

        searcharray = HomeViewController.array.filter({
            return $0.tencongthuc.lowercased().contains(searchText!.lowercased())
        })

        searching = searcharray.count > 0
        self.tableview.reloadData()
    }
}
