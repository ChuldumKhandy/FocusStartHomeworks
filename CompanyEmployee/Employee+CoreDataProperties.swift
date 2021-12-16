//
//  Employee+CoreDataProperties.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var age: Int16
    @NSManaged public var experience: Float
    @NSManaged public var name: String?
    @NSManaged public var company: Company?

}

extension Employee : Identifiable {

}
