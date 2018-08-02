//
//  FoodItem.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftyJSON

struct FoodItem {
    var id: NSNumber
    var nameAr: NSString
    var nameEn: NSString
    var type: NSString
//    var barcode: String
    var timestamp: NSNumber
    var customerId: NSNumber
    var vmId: NSNumber
    var pictureUrl: NSString
    var calories: NSNumber
    var weight: NSNumber
    
    
    
    init?(_ json: JSON) {
        self.id = json["id"].numberValue
        self.nameAr = json["nameAr"].stringValue as NSString
        self.nameEn = json["nameEn"].stringValue as NSString
        self.type   = json["type"].stringValue as NSString
//        self.barcode = json["barcode"].stringValue
        self.timestamp = json["timestamp"].numberValue
        self.customerId = json["customerId"].number ?? NSNumber(integerLiteral: 0)
        self.vmId = json["vmId"].number ?? NSNumber(integerLiteral: 0)
        self.pictureUrl = json["pictureUrl"].stringValue as NSString
        self.calories = json["calories"].numberValue
        self.weight = json["calories"].numberValue
    }
    
    init(_ nameAr: NSString, nameEn: NSString, type: NSString, timestamp: NSNumber, customerId: NSNumber?, vmId: NSNumber?, pictureUrl: NSString, calories: NSNumber, weight: NSNumber) {
        self.nameAr = nameAr as NSString
        self.nameEn = nameEn as NSString
        self.type = type as NSString
        self.timestamp = timestamp
        self.customerId = customerId ?? NSNumber(integerLiteral: 0)
        self.vmId = vmId ?? NSNumber(integerLiteral: 0)
        self.pictureUrl = pictureUrl as NSString
        self.calories = calories
        self.weight = weight
        
        //using NSUserDefaults
        let currentInt = UserDefaults.standard.integer(forKey: "foodId")
        self.id = currentInt != 0 ? NSNumber(integerLiteral: currentInt + 1) : 1
        
        UserDefaults.standard.set((currentInt + 1), forKey: "foodId")
    }
    
    static func load(list: [JSON]) -> [FoodItem] {
        return list.compactMap { FoodItem($0)}
    }

    
    func toDict() -> NSDictionary {
        let dict: NSDictionary = ["nameAr": self.nameAr,
            "nameEn": self.nameEn,
            "type": self.type,
            "timestamp": self.timestamp,
            "customerId": self.customerId,
            "vmId": self.vmId,
            "pictureUrl": self.pictureUrl,
            "calories": self.calories,
            "weight": self.weight,
            "id": self.id]
        return dict
    }
}
