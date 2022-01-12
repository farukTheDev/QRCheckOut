//
//  KeychainManager.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 12.01.2022.
//

import Foundation
import KeychainAccess

class KeychainManager {
    
    static let keychain = Keychain(service: "QRCheckOut.KC")
    
    static func storeString(key: String, value: String){
        keychain[key] = value
    }
    
    static func getString(key: String) -> String?{
        return try? keychain.get(key)
    }
    
}
