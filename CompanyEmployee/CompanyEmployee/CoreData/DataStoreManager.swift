//
//  DataStoreManager.swift
//  CompanyEmployee
//
//  Created by user on 15.12.2021.
//

import Foundation
import CoreData

protocol ICompanyDataStoreManager {
    var fetchCompanyResultController: NSFetchedResultsController<Company> { get }
    func createCompany(name: String)
    func removeCompany(index: Int)
}

protocol IEmployeeDataStoreManager {
    var fetchEmployeeResultController: NSFetchedResultsController<Employee> { get }
    func createEmployee(name: String, age: Int16, experience: NSNumber?, company: Company)
    func removeEmployee(index: Int)
    func getEmployee(company: Company) -> [Employee]?
}

final class DataStoreManager: NSObject {
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
    internal lazy var fetchEmployeeResultController: NSFetchedResultsController<Employee> = {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: self.viewContext,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil)
        fetchedResultController.delegate = self
        try? fetchedResultController.performFetch()
        return fetchedResultController
    }()
    internal lazy var fetchCompanyResultController: NSFetchedResultsController<Company> = {
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: self.viewContext,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil)
        fetchedResultController.delegate = self
        try! fetchedResultController.performFetch()
        return fetchedResultController
    }()
    
    internal func saveContext () {
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

extension DataStoreManager: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
}

extension DataStoreManager: ICompanyDataStoreManager {
    func createCompany(name: String) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        if var companies = try? context.fetch(fetchRequest) as? [Company] {
            let company = Company(context: context)
            company.name = name
            companies.append(company)
            try? context.save()
        }
    }
    
    func removeCompany(index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        if let companies = try? context.fetch(fetchRequest) as? [Company] {
            viewContext.delete(companies[index])
            try? context.save()
        }
    }
}

extension DataStoreManager: IEmployeeDataStoreManager {
    func createEmployee(name: String, age: Int16, experience: NSNumber?, company: Company) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.name)) = %@", company.name)
        guard let company = try? context.fetch(fetchRequest).first as? Company else {
            return }
        let employee = Employee(context: context)
        employee.name = name
        employee.age = age
        if let experience = experience {
            employee.experience = experience
        } else {
            employee.experience = nil
        }
        employee.company = company
        try? context.save()
    }
    
    func removeEmployee(index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        if let employees = try? context.fetch(fetchRequest) as? [Employee] {
            viewContext.delete(employees[index])
            try? context.save()
        }
    }
    
    func getEmployee(company: Company) -> [Employee]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Employee.company.name)) = %@", company.name)
        return try? self.persistentContainer.viewContext.fetch(fetchRequest) as? [Employee]
    }
}
