//
//  FoodItem.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftyJSON

class FoodItem: NSObject {
//    var id: NSString
    var nameAr: NSString
//    var nameEn: NSString
//    var type: NSString
////    var barcode: String
//    var timestamp: NSNumber
//    var customerId: NSNumber
//    var vmId: NSNumber
//    var pictureUrl: NSString
//    var calories: NSNumber
//    var weight: NSNumber
    
    
    
    init?(_ json: JSON) {
//        self.id = json["id"].stringValue as NSString
        self.nameAr = json["nameAr"].stringValue as NSString
//        self.nameEn = json["nameEn"].stringValue as NSString
//        self.type   = json["type"].stringValue as NSString
////        self.barcode = json["barcode"].stringValue
//        self.timestamp = json["timestamp"].numberValue
//        self.customerId = json["customerId"].number ?? NSNumber(integerLiteral: 0)
//        self.vmId = json["vmId"].number ?? NSNumber(integerLiteral: 0)
//        self.pictureUrl = json["pictureUrl"].stringValue as NSString
//        self.calories = json["calories"].numberValue
//        self.weight = json["calories"].numberValue
    }
    
    init(_ nameAr: NSString, nameEn: NSString, type: NSString, timestamp: NSNumber, customerId: NSNumber?, vmId: NSNumber?, pictureUrl: NSString, calories: NSNumber, weight: NSNumber) {
        self.nameAr = nameAr as NSString
//        self.nameEn = nameEn as NSString
//        self.type = type as NSString
//        self.timestamp = timestamp
//        self.customerId = customerId ?? NSNumber(integerLiteral: 0)
//        self.vmId = vmId ?? NSNumber(integerLiteral: 0)
//        self.pictureUrl = pictureUrl as NSString
//        self.calories = calories
//        self.weight = weight
        
//        self.id = UUID().uuidString as NSString
    }
    
    static func load(list: [JSON]) -> [FoodItem] {
        return list.compactMap { FoodItem($0)}
    }

}
