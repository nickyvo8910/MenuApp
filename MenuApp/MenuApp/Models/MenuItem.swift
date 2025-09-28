//
//  MenuItem.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import CoreData

struct MenuItem {
  let id: Int
  let category: String
  let name: String
  let price: Double
}

extension MenuItem {
  func toManagedObject(in context: NSManagedObjectContext) -> MenuItemMO {
    let obj = MenuItemMO(context: context)
    obj.id = Int64(self.id)
    obj.category = self.category
    obj.name = self.name
    obj.price = self.price
    return obj
  }
  
  init?(managedObject obj: MenuItemMO) throws {
    let id = Int(obj.id)
    
    guard let category = obj.category else{
      throw DomainModelMappingError.invalidMapping("lotNo")
    }
    guard let name = obj.category else{
      throw DomainModelMappingError.invalidMapping("name")
    }
    guard let priceString = obj.category,
          let price = Double(priceString),
          price >= 0
    else{
      throw DomainModelMappingError.invalidMapping("price")
    }
    
    self.init(id: id, category: category, name: name, price: price)
  }
}
