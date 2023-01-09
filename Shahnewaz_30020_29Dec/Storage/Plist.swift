//
//  Plist.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//

import Foundation

class PlistHelper{
    func saveData(with dict: [String : Any]) {
        
        // creating the URL for the plist file
        guard let resourceDirPath = Bundle.main.resourcePath else { return }
        print(resourceDirPath)
        
        //let filePath = URL(filePat)
        
        let filePath = URL(fileURLWithPath: resourceDirPath).appendingPathComponent("LoggedInUser.plist", isDirectory: true)
        print(filePath)

        do {
            // converting the dictionary into data (with xml format)
            let data = try PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)
            // writing the data into the plist file
            try data.write(to: filePath)
        } catch {
            print(error)
        }
    }
    
    func getData() -> [String : Any]? {
        
        guard let resourceDirPath = Bundle.main.resourcePath else { return nil }
        print(resourceDirPath)
        let filePath = URL(fileURLWithPath: resourceDirPath).appendingPathComponent("LoggedInUser.plist", isDirectory: true)
        print(filePath)
        
        guard let data = try? Data(contentsOf: filePath) else { return nil }
        
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String : Any] else { return nil }
        
        return plist
    }
    
    func updateLoggedOutData() {
        
        // read the plist as a dictionary from local storage
        guard var plist = getData() else { return }
        
        // update the dictionary
        plist.updateValue(false, forKey: Constants.pListIsLoggedIn)
        plist.removeValue(forKey: Constants.pListUserId)
        
        saveData(with: plist)
    }

    
}
