//
//  MenuItem.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

/// Flexible DTO to match different endpoints
struct MenuItemDto: Decodable {
  let id: Int
  let category: String
  let name: String
  let price: Double
  let description: String?
  let image: String?

  enum CodingKeys: CodingKey {
    case id
    case category
    case name
    case price
    case description
    case image
  }

  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.category = try container.decode(String.self, forKey: .category)
    self.name = try container.decode(String.self, forKey: .name)
    self.price = try container.decode(Double.self, forKey: .price)
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    self.image = try container.decodeIfPresent(String.self, forKey: .image)
  }
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
