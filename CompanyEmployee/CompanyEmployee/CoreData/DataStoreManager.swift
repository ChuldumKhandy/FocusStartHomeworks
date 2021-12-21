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
    func updateCompany(name: String)
    func removeCompany(index: Int)
}

protocol IEmployeeDataStoreManager {
    var fetchEmployeeResultController: NSFetchedResultsController<Employee> { get }
    func updateEmployee(newEmployee: EmployeeModel)
    func getEmployee(for company: Company) -> EmployeeModel?
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

extension DataStoreManager: IEmployeeDataStoreManager {
    func updateEmployee(newEmployee: EmployeeModel) {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.name)) = %@", newEmployee.company.name)
        guard let company = try? viewContext.fetch(fetchRequest).first else { return }
        let employee = Employee(context: viewContext)
        employee.name = newEmployee.name
        employee.age = Int16(newEmployee.age)
        if let experience = newEmployee.experience {
            employee.experience = NSNumber(value: experience)
        } else {
            employee.experience = nil
        }
        employee.company = company
        saveContext()
    }
    
    func getEmployee(for company: Company) -> EmployeeModel? {
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Employee.company.name)) = %@", company.name)
        guard let employee = try? viewContext.fetch(fetchRequest).first.map({ EmployeeModel(employee: $0) }) else {
            return EmployeeModel()
        }
        return employee
    }
}
