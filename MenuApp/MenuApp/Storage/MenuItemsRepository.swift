//
//  MenuItemsRepository.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

protocol MenuItemsRepository{
  
  func create(item: MenuItem) async throws
  
  func replaceFromList(items: [MenuItem]) async throws

  func find(id: Int) async throws -> MenuItem?
  
  func list(category: String?) async throws -> [MenuItem]

  func count() async throws -> Int
  
  func deleteAll() async throws
}

import Foundation
import CoreData

final class CoreDataItemsRepository: MenuItemsRepository{
  let context: NSManagedObjectContext
  
  let encoder = JSONEncoder()
  let decoder = JSONDecoder()

  init(context: NSManagedObjectContext) {
    self.context = context
  }
  
  func create(item: MenuItem) async throws {
    try await self.context.perform {
      let _ = item.toManagedObject(in: self.context)
      try self.context.save()
    }
  }
  
  
  func replaceFromList(items: [MenuItem]) async throws{
    guard items.count > 0 else {
      return
    }
   
    try await deleteAll()
    
    return try await self.context.perform {
      for item in items {
        let _ = item.toManagedObject(in: self.context)
        try self.context.save()
      }
    }
  }
  
  func find(id: Int) async throws -> MenuItem? {
    return try await self.context.perform {
      let fetch = MenuItemMO.fetchRequest()
      let predicates: [NSPredicate] = [
        NSPredicate(format: "id = %d", id as CVarArg)
      ]
      fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)

      let items = try self.context.fetch(fetch)

      guard let item = items.first else {
        return nil
      }

      return try MenuItem(managedObject: item)
    }
  }
  
  func list(category: String?) async throws -> [MenuItem] {
    return try await self.context.perform {
      let fetch = MenuItemMO.fetchRequest()
      if let category = category{
        let predicates: [NSPredicate] = [
          NSPredicate(format: "category = %@", category as CVarArg)
        ]
        fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
      }
      let items = try self.context.fetch(fetch)
      
      var domainItems: [MenuItem] = []
      for item in items{
        if let domainItem = try MenuItem(managedObject: item)
        {
          domainItems.append(domainItem)
        }
      }

      return domainItems
    }
  }
  
  func count() async throws -> Int {
    return try await self.context.perform {
      let fetch = MenuItemMO.fetchRequest()
      let items = try self.context.fetch(fetch)
      return items.count
    }
  }
  
  func deleteAll() async throws {
    try await self.context.perform {
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MenuItemMO")
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      try self.context.execute(request)
    }
  }
  
}

final class MemoryItemsRepository: MenuItemsRepository {
  var items: [MenuItem] = []
  
  init(items: [MenuItem] = []) {
    self.items = items
  }
  
  func create(item: MenuItem) async throws {
    items.append(item)
  }
  
  
  func replaceFromList(items: [MenuItem]) async throws {
    guard items.count > 0 else {
      return
    }
    
    self.items.removeAll()
    self.items = items
  }
  
  func find(id: Int) async throws -> MenuItem? {
    return items.first(where: { $0.id == id })
  }
  
  func list(category: String?) async throws -> [MenuItem] {
    if category != nil {
      return items.filter({$0.category == category})
    } else {
      return items
    }
  }
  
  func count() async throws -> Int {
    return items.count
  }
  
  func deleteAll() async throws {
    items.removeAll()
  }
  
}
