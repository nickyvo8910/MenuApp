//
//  PreviewValues.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//


class PreviewValues {
  static let items = [createItem(id: 1),
                      createItem(id: 2),
                      createItem(id: 3)]
  
  static func createItem(id : Int) -> MenuItem{
    return MenuItem(id: id, category: "cat", name: "name", price: 1.00)
  }
}
