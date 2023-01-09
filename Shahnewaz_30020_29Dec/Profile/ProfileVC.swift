//
//  ProfileVC.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    let userEmail = "ayon@gmail.com"
    let userName = ""
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var taskBackgroundView: UIView!
    
    @IBOutlet weak var totalTask: UILabel!
    @IBOutlet weak var completedTask: UILabel!
    
    
    var completedTasks = 0
    var totalTasks = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerBackgroundView.layer.cornerRadius = 30
        taskBackgroundView.layer.cornerRadius = 20
        taskBackgroundView.dropShadow()
        
        getUserDetails()
        updateTaskSummery()
        
        

        
    }
    
    func updateTaskSummery(){
        for item in StudyTaskModel.studyTasks {
            if item.isDone == true
            {
                completedTasks += 1
            }
        }
        
        completedTask.text = String(completedTasks)
        totalTask.text = String(StudyTaskModel.studyTasks.count)
        
        
    }
    
    func getUserDetails(){
        let userInfo = UserDefaultsHelper().getSavedData(key: Constants.userDefaultsLoggedUser)
        profileName.text = userInfo!.firstName + " " + userInfo!.lastName
        profileEmail.text = userInfo?.email
    }
    

    @IBAction func logOutAction(_ sender: Any) {
        Keychain().deleteSavedData(account: userEmail, service: "token")
        PlistHelper().updateLoggedOutData()
        UserDefaultsHelper().removeSavedData(key: Constants.userDefaultsLoggedUser)
        performSegue(withIdentifier: Constants.segueToSignInId, sender: nil)
        
    }
}
