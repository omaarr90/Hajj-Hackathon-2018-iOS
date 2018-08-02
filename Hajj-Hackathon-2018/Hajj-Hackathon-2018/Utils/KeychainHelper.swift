//
//  KeychainHelper.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftKeychainWrapper

class KeychainHelper {
    private var customKeychainWrapperInstance: KeychainWrapper
    
    public static let shared = KeychainHelper()
    
    private init() {
        let uniqueServiceName = "VendingMachineServiceName"
        let uniqueAccessGroup = "sharedAccessGroupName"
        
        self.customKeychainWrapperInstance = KeychainWrapper(serviceName: uniqueServiceName, accessGroup: uniqueAccessGroup)
    }
    
    func saveUserToken(_ token: String) {
        let _: Bool = KeychainWrapper.standard.set(token, forKey: "token")
    }
    
    func deleteUserToken()
    {
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
    }
    
    func getUserToken() -> String? {
        //
        let retrievedToken = KeychainWrapper.standard.string(forKey: "token", withAccessibility: nil)
        
        return retrievedToken!
    }
    
    
}
