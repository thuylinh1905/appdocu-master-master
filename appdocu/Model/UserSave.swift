//
//  UserSave.swift
//  appdocu
//
//  Created by thuylinh on 9/11/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import Foundation

class UserSave {
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
