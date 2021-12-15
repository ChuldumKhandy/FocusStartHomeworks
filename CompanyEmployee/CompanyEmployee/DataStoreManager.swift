//
//  DataStoreManager.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import Foundation
import CoreData

final class DataStoreManager {
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompanyEmployee")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainMainEmployee() -> Employee {
        let company = Company(context: viewContext)
        company.name = "CFT"
        
        let employee = Employee(context: viewContext)
        employee.name = "Sasha"
        employee.age = 23
        employee.company = company
        
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        
        return employee
    }

}
