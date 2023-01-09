//
//  TimerVC.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 29/12/22.
//

import UIKit
import Lottie

class TimerVC: UIViewController {
    
    var studyTime = 0
    var selectedIndex = 0
    var subjectName = ""
    var topicName = ""
    
    var isPause = false
    var isDelete = true
    

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var countDownAnimationView: LottieAnimationView!
    @IBOutlet weak var countDownTime: UILabel!
    @IBOutlet weak var studyingAnimationView: LottieAnimationView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var topic: UILabel!
    
    
    
    let countDownAnimation = LottieAnimationView(name: "countdown1")
    let studyingAnimation = LottieAnimationView(name: "studyDiscussion")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateCountDownAnimation()
        isDelete = false
        
        studyingAnimation.frame = CGRect(x: 0, y: 0, width: 374, height: 175)
        studyingAnimation.contentMode = .scaleAspectFill
        //studyingAnimation.center = studyingAnimationView.center
        studyingAnimationView.addSubview(studyingAnimation)
        studyingAnimation.loopMode = .loop
        studyingAnimation.play()
        
        
        countDownTime.text = getDisplayableTime(time: studyTime)
        subject.text = subjectName
        topic.text = topicName

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !isDelete{
            CoreDataHelper().updateRecord(index: selectedIndex, task: StudyTaskModel.studyTasks[selectedIndex])
        }
        NotificationCenter.default.post(name: Constants.refreshTaskListNotificationName, object: nil)
    }
    
    
    func initiateCountDownAnimation(){
        countDownAnimation.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        countDownAnimation.contentMode = .scaleAspectFit
        countDownAnimationView.addSubview(countDownAnimation)
        countDownAnimation.loopMode = .loop
        
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getDisplayableTime(time: Int) -> String
    {
        let hour: String
        let min: String
        let sec: String
        let (h,m,s) = secondsToHoursMinutesSeconds(time)
        
        if(h<10){
            hour = "0" + String(h)
        } else
        {
            hour = String(h)
        }
        
        if(m<10){
            min = "0" + String(m)
        } else
        {
            min = String(m)
        }
        
        if(s<10){
            sec = "0" + String(s)
        } else
        {
            sec = String(s)
        }

        return "\(hour) : \(min) : \(sec)"
    }
    
    
    
    @IBAction func resetAction(_ sender: Any) {
        StudyTaskModel.studyTasks[self.selectedIndex].progress = 0
        studyTime = Int(StudyTaskModel.studyTasks[self.selectedIndex].duration)
        countDownTime.text = getDisplayableTime(time: studyTime)

    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        isDelete = true
        CoreDataHelper().deleteRecord(index: selectedIndex)
        NotificationCenter.default.post(name: Constants.refreshTaskListNotificationName, object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func startBtnAction(_ sender: Any) {
        
        if isPause == true { //Clicked on Pause Button
            playBtn.setImage(UIImage(systemName:"play.fill"), for: .normal)
            isPause = false
        }
        else
        {
            //Clicked on Play Button
            playBtn.setImage(UIImage(systemName:"pause.fill"), for: .normal)
            self.countDownAnimation.play()
            self.isPause = true
            var counter = studyTime
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                
                guard let self = self else {return}
                
                if(counter > 0){
                    counter -= 1
                }
                
                DispatchQueue.main.async {
                    let displayableTime = self.getDisplayableTime(time: counter)
                    self.countDownTime.text = displayableTime
                }
                if counter == 0 {
                    timer.invalidate()
                    self.countDownAnimation.stop()
                    self.countDownTime.text = "00 : 00 : 00"
                    self.playBtn.setImage(UIImage(systemName:"play.fill"), for: .normal)
                    self.studyTime = counter
                    StudyTaskModel.studyTasks[self.selectedIndex].progress = StudyTaskModel.studyTasks[self.selectedIndex].duration - Int32(self.studyTime)
                    StudyTaskModel.studyTasks[self.selectedIndex].isDone = true
                    return
                }
                else if (self.isPause == false)
                {
                    self.studyTime = counter
                    self.countDownAnimation.stop()
                    timer.invalidate()
                    StudyTaskModel.studyTasks[self.selectedIndex].progress = StudyTaskModel.studyTasks[self.selectedIndex].duration - Int32(self.studyTime)
                    return
                }
                
        }
    }
}
}
