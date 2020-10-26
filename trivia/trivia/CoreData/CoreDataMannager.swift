//
//  CoreDataMannager.swift
//  trivia
//
//  Created by Franco Ghiotti on 26/10/2020.
//

import UIKit
import CoreData

class CoreDataMannager {

    func fetchObject() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TriviaResults")

        do {
            return try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
          }
    }

    func addResult(resultToSave: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "TriviaResults", in: managedContext)!

        let result = NSManagedObject(entity: entity, insertInto: managedContext)

        result.setValue(resultToSave, forKeyPath: "result")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
