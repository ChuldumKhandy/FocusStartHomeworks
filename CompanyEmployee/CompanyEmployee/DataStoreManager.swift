//
//  DataStoreManager.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import Foundation
import CoreData

protocol IDataStoreManager {
    func obtainCompany() -> [Company]?
    func updateCompany(name: String)
    func removeCompany(index: Int)
}

final class DataStoreManager {
    private lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    private lazy var persistentContainer: NSPersistentContainer = {
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
}

extension DataStoreManager: IDataStoreManager {
    func obtainCompany() -> [Company]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        guard let companies = try? viewContext.fetch(fetchRequest) as? [Company] else {
            return nil }
        return companies
    }
    
    func updateCompany(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        if var companies = try? viewContext.fetch(fetchRequest) as? [Company] {
            let company = Company(context: viewContext)
            company.name = name
            companies.append(company)
            saveContext()
        }
    }
    
    func removeCompany(index: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        if let companies = try? viewContext.fetch(fetchRequest) as? [Company] {
            viewContext.delete(companies[index])
            saveContext()
        }
    }
}
