//
//  User+CoreDataProperties.swift
//  FGI
//
//  Created by user on 27.12.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var uid: UUID
    @NSManaged public var login: String
    @NSManaged public var password: String

}

extension User : Identifiable {

}
