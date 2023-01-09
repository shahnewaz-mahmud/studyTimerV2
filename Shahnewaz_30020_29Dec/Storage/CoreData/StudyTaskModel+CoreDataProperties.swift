//
//  StudyTaskModel+CoreDataProperties.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 1/9/23.
//
//

import Foundation
import CoreData


extension StudyTaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudyTaskModel> {
        return NSFetchRequest<StudyTaskModel>(entityName: "StudyTaskModel")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var isDone: Bool
    @NSManaged public var priority: String?
    @NSManaged public var progress: Int32
    @NSManaged public var subject: String?
    @NSManaged public var taskId: String?
    @NSManaged public var topic: String?
    @NSManaged public var userId: UserModel?
    
    static var studyTasks = [StudyTaskModel]()

}

extension StudyTaskModel : Identifiable {

}
