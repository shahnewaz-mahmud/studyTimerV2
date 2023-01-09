//
//  UserDefaults.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//

import Foundation


class UserDefaultsHelper {
    
    func saveData(data: Data, key: String){
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getSavedData(key: String) -> User?{
        guard let fetchedData = UserDefaults.standard.data(forKey: Constants.userDefaultsLoggedUser) else { return nil }
        let decoder = JSONDecoder()
        let userInfo = try? decoder.decode(User.self, from: fetchedData)
        return userInfo
        
    }
    
    func removeSavedData(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }

}
