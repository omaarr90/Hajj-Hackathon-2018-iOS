//
//  User.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftyJSON

struct User {
    var displayName: String
    var token: String?
    
    init?(_ json: JSON) {
        self.token = json["token"].stringValue
        self.displayName = json["displayName"].stringValue
    }
    
    static func load(list: [JSON]) -> [User] {
        return list.compactMap { User($0)}
    }
    static func currentUser() {
        
    }
}
