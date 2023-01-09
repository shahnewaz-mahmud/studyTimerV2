//
//  CoreDataHelper.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//

import Foundation
import UIKit

class CoreDataHelper{
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllRecords() {
        do {
            StudyTaskModel.studyTasks = try CoreDataHelper.context.fetch(StudyTaskModel.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func addRecord(task: StudyTaskModel) {

        do {
            try CoreDataHelper.context.save()
            StudyTaskModel.studyTasks.append(task)
        } catch {
            print(error)
        }
        getAllRecords()
        print(StudyTaskModel.studyTasks.count)
        
    }
    
    func deleteRecord(index: Int) {
        getAllRecords()
        print(StudyTaskModel.studyTasks.count)
        
        let item = StudyTaskModel.studyTasks[index]
        CoreDataHelper.context.delete(item)
        do {
            try CoreDataHelper.context.save()
            StudyTaskModel.studyTasks.remove(at: index)
        } catch {
            print("Delete Error: ", error)
        }
        
        getAllRecords()
        print(StudyTaskModel.studyTasks.count)
    }
    
    func updateRecord(index: Int, task: StudyTaskModel) {
        StudyTaskModel.studyTasks[index] = task
        

        do {
            try CoreDataHelper.context.save()
        } catch {
            print(error)
        }
    }
    
}
