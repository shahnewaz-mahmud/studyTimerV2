//
//  StartPageVC.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//

import UIKit

class StartPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loggedInfo = PlistHelper().getData()
        if let loggedInfo = loggedInfo {
            if(loggedInfo[Constants.pListIsLoggedIn]! as! Bool == true){
                performSegue(withIdentifier: Constants.segueToHomePage, sender: nil)
            }
        }

    }

}
