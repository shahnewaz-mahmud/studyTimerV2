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
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var taskBackgroundView: UIView!
    @IBOutlet weak var totalTask: UILabel!
    @IBOutlet weak var completedTask: UILabel!
    @IBOutlet weak var toggleBtn: UISwitch!
    
    @IBOutlet weak var profilePhoneNum: UILabel!
    
    
    var completedTasks = 0
    var totalTasks = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        headerBackgroundView.layer.cornerRadius = 30
        taskBackgroundView.layer.cornerRadius = 20
        taskBackgroundView.dropShadow()
        
        getUserInfoFromUserDefaults()
        updateTaskSummery()

    }
    
    
    
    @IBAction func toggleBtnAction(_ sender: Any) {
        
        if toggleBtn.isOn{
            getUserInfoFromUserDefaults()
            showToast(controller: self, message: "Data Fetched from User Defaults", seconds: 1.0)
        }
        else
        {
            getUserInfoFromCoreData()
            showToast(controller: self, message: "Data Fetched from Core Data", seconds: 1.0)
        }
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
    
    func getUserInfoFromUserDefaults(){
        let userInfo = UserDefaultsHelper().getSavedData(key: Constants.userDefaultsLoggedUser)
        profileName.text = userInfo!.firstName + " " + userInfo!.lastName
        profileEmail.text = userInfo?.email
        profilePhoneNum.text = userInfo?.phone
        
    }
    
    func getUserInfoFromCoreData(){
        let loggedInfo = PlistHelper().getData()
        if let loggedInfo = loggedInfo {
            let userId = loggedInfo[Constants.pListUserId]! as! String
            let userInfo = CoreDataHelper().getUserInfo(userId: userId)
            profileName.text = (userInfo?.fistName)! + " " + (userInfo?.lastName)!
            
            let userContact = CoreDataHelper().getUserContact(userId: userId)
            profileEmail.text = (userContact?.email)!
            profilePhoneNum.text = (userContact?.phone)!
        }
    }
    

    @IBAction func logOutAction(_ sender: Any) {
        Keychain().deleteSavedData(account: userEmail, service: "token")
        PlistHelper().updateLoggedOutData()
        UserDefaultsHelper().removeSavedData(key: Constants.userDefaultsLoggedUser)
        performSegue(withIdentifier: Constants.segueToSignInId, sender: nil)
        
    }
    
    
    func showToast(controller: UIViewController, message : String, seconds: Double)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
        
    }
}
