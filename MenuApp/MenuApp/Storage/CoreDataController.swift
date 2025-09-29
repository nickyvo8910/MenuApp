//
//  CoreDataController.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import CoreData

enum StorageType {
  case persistent, inMemory
}

struct CoreDataController {

  static let shared = CoreDataController()

  var context: NSManagedObjectContext {
    return container.viewContext
  }

  let container: NSPersistentContainer

  init(_ storageType: StorageType = .persistent) {
    container = NSPersistentContainer(name: "MenuApp")

    if storageType == .inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }

    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        //         Replace this implementation with code to handle the error appropriately.
        //         fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //
        //        /*
        //                 Typical reasons for an error here include:
        //                 * The parent directory does not exist, cannot be created, or disallows writing.
        //                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
        //                 * The device is out of space.
        //                 * The store could not be migrated to the current model version.
        //                 Check the error message to determine what the actual problem was.
        //                 */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
}
