//
//  UserModel+CoreDataProperties.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 1/9/23.
//
//

import Foundation
import CoreData


extension UserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "UserModel")
    }

    @NSManaged public var fistName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var userId: String?
    @NSManaged public var tasks: NSSet?
    @NSManaged public var contact: ContactModel?

}

// MARK: Generated accessors for tasks
extension UserModel {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: StudyTaskModel)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: StudyTaskModel)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension UserModel : Identifiable {

}
