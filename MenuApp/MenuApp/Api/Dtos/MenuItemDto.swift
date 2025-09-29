//
//  MenuItem.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

struct MenuItemDto: Decodable {
  let id: Int
  let category: String
  let name: String
  let price: Double
  let description: String?
  let image: String?
}

extension MenuItemDto {
  func toDomainModel() -> MenuItem {
    return MenuItem(
      id: id,
      category: category,
      name: name,
      price: price,
      description: description,
      image: image
    )
  }
}
