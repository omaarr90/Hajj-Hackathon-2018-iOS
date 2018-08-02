//
//  VendingMachine.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftyJSON

class VendingMachine: NSObject {
    var addressAr: NSString
    var addressEn: NSString
    var foodList: NSArray
    var id: NSNumber
    var latitude: NSString
    var longitude: NSString
    var name: NSString
    var timestamp: NSNumber
    
    init?(_ json: JSON) {
        self.addressAr = json["addressAr"].stringValue as NSString
        self.addressEn = json["addressEn"].stringValue as NSString
        self.foodList = FoodItem.load(list: json["foodList"].arrayValue) as NSArray
        self.id   = json["id"].numberValue
        self.latitude = json["latitude"].stringValue as NSString
        self.longitude = json["longitude"].stringValue as NSString
        self.name = json["name"].stringValue as NSString
        self.timestamp = json["timestamp"].numberValue
    }
    
    static func load(list: [JSON]) -> [VendingMachine] {
        return list.compactMap { VendingMachine($0)}
    }
}


/**
 {
 "result": [
 {
 "addressAr": "عرفات ٠٠١",
 "addressEn": "Arafat 001",
 "foodList": [],
 "id": 1,
 "latitude": 39.9944045072035,
 "longitude": 21.3538259485247,
 "name": "VM001",
 "timestamp": "2018-08-01T17:02:04.364"
 },
 {
 "addressAr": "عرفات ٠٠٢",
 "addressEn": "Arafat 002",
 "foodList": [],
 "id": 2,
 "latitude": 39.9953463520639,
 "longitude": 21.3530238827885,
 "name": "VM002",
 "timestamp": "2018-08-01T17:02:04.371"
 },
 {
 "addressAr": "منى ٠٠١",
 "addressEn": "Mina 001",
 "foodList": [],
 "id": 3,
 "latitude": 39.9123936220162,
 "longitude": 21.3997744595588,
 "name": "VM003",
 "timestamp": "2018-08-01T17:02:04.375"
 }
 ],
 "status": "success"
 }
 */
