//
//  NewFeedModel.swift
//  appdocu
//
//  Created by thuylinh on 8/9/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import Foundation
class NewFeedModel {
    
    var diachi : String
    var giatien : String
    var mota : String
    var tenquan : String
    var username : String!
    var image : [String]!
    
    init(diachi : String , giatien : String, mota : String, tenquan : String, username : String , image : [String]) {
        self.diachi = diachi
        self.giatien = giatien
        self.mota = mota
        self.tenquan = tenquan
        self.username = username
        self.image = image
    }
}
