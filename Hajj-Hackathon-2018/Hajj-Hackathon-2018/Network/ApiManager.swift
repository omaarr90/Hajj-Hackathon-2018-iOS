//
//  ApiManager.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import Foundation

import HermesNetwork
import Alamofire
import Hydra
import SwiftyJSON

class ApiManager {
    
    public static let shared = ApiManager()
    
    var cnfg: ServiceConfig
    var service: Service
    
    private init() {
        self.cnfg = ServiceConfig(base: "https://api.fouad.io")!
        self.service = Service(self.cnfg)
    }
}


//Api Request
extension ApiManager {
    func login(_ username: String, withPassword password: String, completion: @escaping (User?, Error?) -> Void) {
        let op: JSONOperation<User> = JSONOperation<User>()
        
        op.request = Request(method: .post, endpoint: "/user/login", params: nil, fields: nil, body: RequestBody.json(["username": username, "password": password]))
        
        op.request?.headers = ["Content-Type": "application/json"]
        op.onParseResponse = { json in
            return User(json["result"])!
        }
        op.execute(in: self.service).then { user in
            completion(user, nil)
            }.catch { error in
                completion(nil, error)
        }
    }
    
    func getCustomerEligibility(_ customerId: NSNumber, completion: @escaping (Bool) -> Void) {
        let op: JSONOperation<Bool> = JSONOperation<Bool>()
        
        op.request = Request(method: .get, endpoint: "/customer/eligibility", params: nil, fields: ["customerId": customerId], body: nil)
        
        let token = KeychainHelper.shared.getUserToken()!
        op.request?.headers = ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        op.onParseResponse = { json in
            return json["result"]["eligible"].boolValue
        }
        op.execute(in: self.service).then {result in
            completion(result)
            }.catch {_ in}
    }


    func withdraw(food foodId: NSString, fromMachine vmId: NSNumber, customerId: NSNumber, completion: @escaping (Error?) -> Void) {
        let op: JSONOperation<Bool> = JSONOperation<Bool>()
        
        //        let bodyData = "username=\(username)&password=\(password)".data(using:String.Encoding.ascii, allowLossyConversion: false)
        op.request = Request(method: .post, endpoint: "/vm/withdraw", params: nil, fields: nil, body: RequestBody.json(["foodId": foodId, "vmId": vmId, "customerId": customerId]))
        
        let token = KeychainHelper.shared.getUserToken()!
        op.request?.headers = ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        op.onParseResponse = { json in
            return true
        }
        op.execute(in: self.service).then {result in completion(nil)}.catch {error in completion(error)}

    }

    
    func getAllMachines(completion: @escaping ([VendingMachine]?, Error?) -> Void) {
        let op: JSONOperation<[VendingMachine]> = JSONOperation<[VendingMachine]>()
        
        op.request = Request(method: .get, endpoint: "/vm/all", params: nil, fields: nil, body: nil)
        
        //        op.request?.headers = ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        op.onParseResponse = { json in
            return VendingMachine.load(list: json["result"].arrayValue)
        }
        op.execute(in: self.service).then { vendingMachine in
            completion(vendingMachine, nil)
            }.catch { error in
                completion(nil, error)
        }
    }

    func getMachineInfo(for vmId: NSNumber, completion: @escaping (VendingMachine?, Error?) -> Void) {
        let op: JSONOperation<VendingMachine> = JSONOperation<VendingMachine>()
        
        op.request = Request(method: .get, endpoint: "/vm/\(vmId)", params: nil, fields: nil, body: nil)
        
        let token = KeychainHelper.shared.getUserToken()!
        op.request?.headers = ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        op.onParseResponse = { json in
            return VendingMachine(json["result"])!
        }
        op.execute(in: self.service).then { vendingMachine in
            completion(vendingMachine, nil)
            }.catch { error in
                completion(nil, error)
        }
    }
    
    func supplyMachine(_ foodItems: NSArray, machineID: NSNumber, completion: @escaping (Bool) -> Void) {
        let op: JSONOperation<Bool> = JSONOperation<Bool>()
        
//        let array: NSArray = ["Omar", "Ahmed"]
        let jsonDict: NSDictionary = ["vmId": machineID, "foodList": foodItems]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
//        let body = RequestBody.json(["vmId": machineID, "foodList": foodItems])
        let body = RequestBody.raw(data: jsonData)
        op.request = Request(method: .post, endpoint: "/vm/supply", params: nil, fields: nil, body: body)
        
        let token = KeychainHelper.shared.getUserToken()!
        op.request?.headers = ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
        op.onParseResponse = { _ in
            return true
        }
        op.execute(in: self.service).then {result in
            completion(result)
            }.catch {_ in}
    }

    func updateLocation(_ vmId: NSNumber, lat: NSNumber, lon: NSNumber) {
        let op: JSONOperation<Bool> = JSONOperation<Bool>()
        
        op.request = Request(method: .get, endpoint: "/vm/location", params: nil, fields: nil, body: RequestBody.json(["vmId": vmId, "latitude": lat, "longitude": lon]))
        
        //        op.request?.headers = ["Content-Type": "application/json"]
        //        op.onParseResponse = nil
        op.execute(in: self.service).then {_ in }.catch {_ in}
    }

}
