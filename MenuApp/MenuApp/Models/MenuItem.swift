//
//  MenuItem.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import CoreData

struct MenuItem: Hashable {
  let id: Int
  let category: String
  let name: String
  let price: Double
  var description: String? = nil
  var image: String? = nil
}

extension MenuItem {
  func toManagedObject(in context: NSManagedObjectContext) -> MenuItemMO {
    let obj = MenuItemMO(context: context)
    obj.id = Int64(self.id)
    obj.category = self.category
    obj.name = self.name
    obj.price = self.price
    
    // Descriptions and images are not saved locally. Hence, missing from this function
    return obj
  }
  
  init?(managedObject obj: MenuItemMO) throws {
    let id = Int(obj.id)
    let price = Double(obj.price)
    
    guard let category = obj.category else{
      throw DomainModelMappingError.invalidMapping("category")
    }
    guard let name = obj.name else{
      throw DomainModelMappingError.invalidMapping("name")
    }
    
    // Descriptions and images are not saved locally
    self.init(id: id, category: category, name: name, price: price,description: nil, image: nil)
  }
}
