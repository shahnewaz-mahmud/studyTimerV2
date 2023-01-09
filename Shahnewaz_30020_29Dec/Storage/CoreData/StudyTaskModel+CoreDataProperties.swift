//
//  StudyTaskModel+CoreDataProperties.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 8/1/23.
//
//

import Foundation
import CoreData


extension StudyTaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudyTaskModel> {
        return NSFetchRequest<StudyTaskModel>(entityName: "StudyTaskModel")
    }

    @NSManaged public var taskId: String?
    @NSManaged public var userId: String?
    @NSManaged public var subject: String?
    @NSManaged public var topic: String?
    @NSManaged public var duration: Int32
    @NSManaged public var progress: Int32
    @NSManaged public var priority: String?
    @NSManaged public var isDone: Bool
    
    
    static var studyTasks = [StudyTaskModel]()

}

extension StudyTaskModel : Identifiable {

}
