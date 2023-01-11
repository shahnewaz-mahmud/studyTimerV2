//
//  ViewController.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 12/29/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
  
    
    @IBOutlet weak var midBackground: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    
    var syncNumber = 0
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        syncUserDetails()
        getAllUserTasks()
       
        
        print("Total Data",StudyTaskModel.studyTasks.count)
        
        
        midBackground.layer.cornerRadius = 50
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let taskCollectionCellNib = UINib(nibName: Constants.TaskCVCellId, bundle: nil)
        collectionView.register(taskCollectionCellNib, forCellWithReuseIdentifier: Constants.TaskCVCellId)
        
        // configure the collection view.
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 250, height: 300)
        collectionViewCellLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewCellLayout
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTaskList), name: Constants.refreshTaskListNotificationName, object: nil)
        
        
    }
    
    
    @IBAction func taskSegmentAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0
        {
            getAllUserTasks()
            refreshTaskList()
        }else
        {
            getAllCompletedTasks()
            refreshTaskList()
        }
    }
    
    
    func updateHomeHeader(){
        DispatchQueue.main.async {
            let userInfo = UserDefaultsHelper().getSavedData(key: Constants.userDefaultsLoggedUser)
            self.userName.text = userInfo?.firstName
        }
    }
    
    @objc func refreshTaskList() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func syncUserDetails(){
        let loggedInfo = PlistHelper().getData()
        if let loggedInfo = loggedInfo {
            let userId = loggedInfo[Constants.pListUserId]! as! String
            print(userId)
            
            guard let url = URL(string: Constants.apidomain + "users/" + userId) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("There was an error: \(error.localizedDescription)")
                } else {
                    UserDefaultsHelper().saveData(data: data!, key: Constants.userDefaultsLoggedUser)
                    self.updateHomeHeader()
                }
            }.resume()
        }
 
    }
    
    func getAllUserTasks()
    {
        let loggedInfo = PlistHelper().getData()
        if let loggedInfo = loggedInfo {
            let userId = loggedInfo[Constants.pListUserId]! as! String
            CoreDataHelper().getAllTask(userId: userId)  
        }
    }
    
    func getAllCompletedTasks()
    {
        let loggedInfo = PlistHelper().getData()
        if let loggedInfo = loggedInfo {
            let userId = loggedInfo[Constants.pListUserId]! as! String
            CoreDataHelper().getAllDoneRecords(userId: userId)
        }
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StudyTaskModel.studyTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let taskCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.TaskCVCellId, for: indexPath) as! TaskCVCell
        
        taskCollectionViewCell.subject.text = StudyTaskModel.studyTasks[indexPath.row].subject
        taskCollectionViewCell.topic.text = StudyTaskModel.studyTasks[indexPath.row].topic
        
        let (h, m, _) = secondsToHoursMinutesSeconds(Int(StudyTaskModel.studyTasks[indexPath.row].duration))
        
        taskCollectionViewCell.duration.text = "\(h) Hours \(m) Min"
        taskCollectionViewCell.priority.text = StudyTaskModel.studyTasks[indexPath.row].priority
        taskCollectionViewCell.taskProgressBar.progress = Float(StudyTaskModel.studyTasks[indexPath.row].progress)/Float(StudyTaskModel.studyTasks[indexPath.row].duration)
        
        var cardAnimation: LottieAnimationView
        
        if(StudyTaskModel.studyTasks[indexPath.row].isDone == true){
             cardAnimation = LottieAnimationView(name: "done")
        }
        else
        {
             cardAnimation = LottieAnimationView(name: "studying")
        }
        
        cardAnimation.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        cardAnimation.contentMode = .scaleAspectFit
        taskCollectionViewCell.cardAnimationView.addSubview(cardAnimation)
        cardAnimation.play()
        cardAnimation.loopMode = .loop
        
        
        return taskCollectionViewCell
    }
    

    
}


extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Constants.SegueToTimerVCId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueToTimerVCId {
            if let destination = segue.destination as? TimerVC{
                destination.studyTime = Int(StudyTaskModel.studyTasks[selectedIndex].duration - StudyTaskModel.studyTasks[selectedIndex].progress)
                destination.selectedIndex = selectedIndex
                destination.subjectName = StudyTaskModel.studyTasks[selectedIndex].subject ?? ""
                destination.topicName = StudyTaskModel.studyTasks[selectedIndex].topic ?? ""

            }
        }
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

