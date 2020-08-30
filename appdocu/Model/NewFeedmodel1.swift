//
//  NewFeedmodel1.swift
//  appdocu
//
//  Created by thuylinh on 8/12/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//
//let tencongthuc = dic["tencongthuc"] as! String
//let motacongthuc = dic["motacongthuc"] as! String
//let khauphan = dic["khauphan"] as! String
//let thoigiannau = dic["thoigiannau"] as! String
//let nguyenlieu = dic["nguyenlieu"] as! [String]
//let congthuc = dic["congthucnau"] as! [String]
import Foundation
class NewFeedmodel1 {
    var tencongthuc : String
    var motacongthuc : String
    var khauphan : String
    var thoigiannau : String
    var username : String!
    var imageprofile : String!
    var image : [String]!
    var nguyenlieu : [String]!
    var congthuc : [String]!
    var keyid : String
    
    init(tencongthuc : String , motacongthuc : String, khauphan : String, thoigiannau : String, username : String , image : [String], imageprofile : String, nguyenlieu : [String] , congthuc : [String] , keyid : String) {
        self.tencongthuc = tencongthuc
        self.motacongthuc = motacongthuc
        self.khauphan = khauphan
        self.thoigiannau = thoigiannau
        self.username = username
        self.image = image
        self.imageprofile = imageprofile
        self.nguyenlieu = nguyenlieu
        self.congthuc = congthuc
        self.keyid = keyid
    }
}
