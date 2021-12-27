//
//  CoreDataManager.swift
//  FGI
//
//  Created by user on 23.12.2021.
//

import UIKit
import CoreData

protocol ICoreDataManager {
    func getUser(login: String, password: String) -> LogInUser?
    func saveUser(user: LogInUser, completion: @escaping () -> Void)
}

final class CoreDataManager {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FGI")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension CoreDataManager: ICoreDataManager {
    func getUser(login: String, password: String) -> LogInUser? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.login)) = '\(login)' && \(#keyPath(User.password)) = '\(password)'")
        guard let object = try? self.persistentContainer.viewContext.fetch(fetchRequest).first else { return nil }
        return LogInUser(user: object)
    }

    func saveUser(user: LogInUser, completion: @escaping () -> Void) {
        self.persistentContainer.performBackgroundTask { context in
            let object = User(context: context)
            object.uid = user.uid
            object.login = user.login
            object.password = user.password
            try? context.save()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { completion() })
        }
    }
}
