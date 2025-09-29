//
//  MenuItemService.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import Alamofire
import Factory

protocol MenuItemService {
  func downloadMenuItems() async throws -> [MenuItemDto]
  func loadItemDetails(id: Int) async throws -> MenuItemDto
}

final class MenuItemServiceImpl: MenuItemService {
  @Injected(\.apiClient) private var apiClient: ApiClient

  func downloadMenuItems() async throws -> [MenuItemDto] {
    let url = apiClient.baseUrl + "menu/"

    let response = await AF.request(
      url,
      method: .get,
      interceptor: .retryPolicy
    )
    .validate(statusCode: 200..<300)
    .serializingDecodable([MenuItemDto].self)
    .response

    return try apiClient.handleResponse(response: response)
  }

  func loadItemDetails(id: Int) async throws -> MenuItemDto {
    guard id >= 0 else {
      throw ApiError.invalidParams
    }

    let url = apiClient.baseUrl + "menu/\(id)"

    let response = await AF.request(
      url,
      method: .get,
      interceptor: .retryPolicy
    )
    .validate(statusCode: 200..<300)
    .serializingDecodable(MenuItemDto.self)
    .response

    return try apiClient.handleResponse(response: response)
  }
}
