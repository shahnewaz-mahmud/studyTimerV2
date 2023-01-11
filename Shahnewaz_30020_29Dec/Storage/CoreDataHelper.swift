//
//  CoreDataHelper.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    func getAllTask(userId: String) {
        let fetchRequest = NSFetchRequest<StudyTaskModel>(entityName: "StudyTaskModel")
        let format = "userId = %@"
        let predicate = NSPredicate(format: format,userId)
        fetchRequest.predicate = predicate
        
        do {
            StudyTaskModel.studyTasks = try context.fetch(fetchRequest)
            StudyTaskModel.studyTasks.reverse()
        } catch {
            print(error)
        }
    }
    
    func getAllDoneRecords(userId: String) {
        let fetchRequest = NSFetchRequest<StudyTaskModel>(entityName: "StudyTaskModel")
        let format = "userId = %@ && isDone == true"
        let predicate = NSPredicate(format: format,userId)
        fetchRequest.predicate = predicate
        
        do {
            StudyTaskModel.studyTasks = try context.fetch(fetchRequest)
            StudyTaskModel.studyTasks.reverse()
        } catch {
            print(error)
        }
    }
    
    
    
    func addTask(userId: String, taskId: String, subject: String, topic: String, duration: Int32, progress: Int32, priority: String, isDone: Bool ) {

        let newTask = StudyTaskModel(context: context)
        newTask.taskId = taskId
        newTask.subject = subject
        newTask.topic = topic
        newTask.duration = duration
        newTask.progress = progress
        newTask.priority = priority
        newTask.isDone = isDone
        
        let fetchRequest = NSFetchRequest<UserModel>(entityName: "UserModel")
        let predicate = NSPredicate(format: "userId == %@", userId)
        fetchRequest.predicate = predicate
        
        
        do {
            let user = try context.fetch(fetchRequest).first
            user?.addToTasks(newTask)
            try context.save()
        } catch {
            print(error)
        }
        getAllTask(userId: userId)
        print(StudyTaskModel.studyTasks.count)
        
    }
    
    func deleteRecord(index: Int) {
        let item = StudyTaskModel.studyTasks[index]
        context.delete(item)
        do {
            try context.save()
            StudyTaskModel.studyTasks.remove(at: index)
        } catch {
            print("Delete Error: ", error)
        }
    }
    
    func updateRecord(index: Int, task: StudyTaskModel) {
        StudyTaskModel.studyTasks[index] = task
        

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func addUser(userInfo: User){
        
        let user = UserModel(context: context)
        user.userId = userInfo.userId
        user.fistName = userInfo.firstName
        user.lastName = userInfo.lastName
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func addContact(userInfo: User)
    {
        let contact = ContactModel(context: context)
        contact.email = userInfo.email
        contact.phone = userInfo.phone
        
        let fetchRequest = NSFetchRequest<UserModel>(entityName: "UserModel")
        let predicate = NSPredicate(format: "userId == %@", userInfo.userId!)
        fetchRequest.predicate = predicate
        
        do {
            let user = try context.fetch(fetchRequest).first
            user?.contact = contact
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getUserInfo(userId: String) -> UserModel?{
        let fetchRequest = NSFetchRequest<UserModel>(entityName: "UserModel")
        let format = "userId = %@"
        let predicate = NSPredicate(format: format,userId)
        fetchRequest.predicate = predicate
        
        do {
            let userInfo = try context.fetch(fetchRequest).first
            return userInfo
        } catch {
            print(error)
           
        }
        return nil
    }
    
    func getUserContact(userId: String) -> ContactModel?{
        let fetchRequest = NSFetchRequest<ContactModel>(entityName: "ContactModel")
        let format = "userId = %@"
        let predicate = NSPredicate(format: format,userId)
        fetchRequest.predicate = predicate
        
        do {
            let userContact = try context.fetch(fetchRequest).first
            return userContact
        } catch {
            print(error)
           
        }
        return nil
    }
}
