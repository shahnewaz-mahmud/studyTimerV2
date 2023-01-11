//
//  AddTaskVC.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 12/30/22.
//

import UIKit
import Lottie

class AddTaskVC: UIViewController {

    @IBOutlet weak var studentAnimationView: LottieAnimationView!
    
    
    @IBOutlet weak var subjectInput: UITextField!
    
    @IBOutlet weak var topicInput: UITextField!
    
    @IBOutlet weak var hourInput: UITextField!
    
    @IBOutlet weak var minInput: UITextField!
    
    @IBOutlet weak var priorityInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let studentAnimation = LottieAnimationView(name: "student")
        studentAnimation.frame = CGRect(x: 0, y: 0, width: 370, height: 200)
        studentAnimation.contentMode = .scaleAspectFit
        //cardAnimation.center = cardAnimationView.center
        studentAnimationView.addSubview(studentAnimation)
        studentAnimation.play()
        studentAnimation.loopMode = .loop
    }

    @IBAction func addTaskBtnAction(_ sender: Any) {
        
        let duration = Int(hourInput.text!)!*60*60 + Int(Float(minInput.text!)!*60)
        let loggedInfo = PlistHelper().getData()
        if let loggedInfo = loggedInfo {
            let userId = loggedInfo[Constants.pListUserId]! as! String
            
            CoreDataHelper().addTask(userId: userId, taskId: String(Int.random(in: 1...999)), subject: subjectInput.text ?? "", topic: topicInput.text ?? "", duration: Int32(duration), progress: 0, priority: priorityInput.text ?? "", isDone: false)
            
            NotificationCenter.default.post(name: Constants.refreshTaskListNotificationName, object: nil)
            dismiss(animated: true)
        }
    
    }
    
}
