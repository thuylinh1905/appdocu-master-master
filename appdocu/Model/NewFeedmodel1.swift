//
//  NewFeedmodel1.swift
//  appdocu
//
//  Created by thuylinh on 8/12/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//
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
    var like : Int
    var uid : String
    
    init(tencongthuc : String , motacongthuc : String, khauphan : String, thoigiannau : String, username : String , image : [String], imageprofile : String, nguyenlieu : [String] , congthuc : [String] , keyid : String, like : Int , uid : String) {
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
        self.like = like
        self.uid = uid
    }
}
class UserComment {
    var image : String
    var username : String
    var comment : String
    init(image : String , username : String , comment : String) {
        self.image = image
        self.username = username
        self.comment =  comment
    }
}
class MenuFood {
    var name : String
    var image : String
    init(name : String, image : String) {
        self.name = name
        self.image = image
    }
}
