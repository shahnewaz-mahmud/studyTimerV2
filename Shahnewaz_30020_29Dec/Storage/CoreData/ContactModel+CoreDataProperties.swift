//
//  ContactModel+CoreDataProperties.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 1/9/23.
//
//

import Foundation
import CoreData


extension ContactModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactModel> {
        return NSFetchRequest<ContactModel>(entityName: "ContactModel")
    }

    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var userId: UserModel?

}

extension ContactModel : Identifiable {

}
