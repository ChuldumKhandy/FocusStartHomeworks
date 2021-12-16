//
//  Company+CoreDataProperties.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var employee: Employee?

}

extension Company : Identifiable {

}
