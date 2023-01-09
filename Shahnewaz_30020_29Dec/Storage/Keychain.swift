//
//  Keychain.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 7/1/23.
//

import Foundation

class Keychain{
    
    func saveData(account: String, service: String, data: String) {
        
        guard let data = try? JSONEncoder().encode(data) else {
            return
        }
        
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecValueData: data
        ] as CFDictionary

        SecItemAdd(query, nil)
    }
    
    func getSavedData(account: String, service: String) -> String {
    
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            if let result = result as? [CFString : Any] {
                if let data = result[kSecValueData] as? Data {
                    let decodedData = try? JSONDecoder().decode(String.self, from: data)
                    return decodedData!
                }
            }
        } else {
            return ""
        }
        return ""
    }
    
    
    func deleteSavedData(account: String, service: String) {
        let account = "test@gmail.com"
        let service = "password"
        
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    
    func updateSavedData(account: String, service: String, data: String) {
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
        ] as CFDictionary

        let dataEncoded = try? JSONEncoder().encode(data)
        
        let attributesToUpdate = [
            kSecValueData : dataEncoded
        ] as CFDictionary
        
        let status = SecItemUpdate(query, attributesToUpdate)
        
        if status == errSecSuccess {
            print("update successful")
        } else {
            print(status)
        }
    }

    
}


