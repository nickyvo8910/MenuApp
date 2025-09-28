//
//  SyncServiceProtocol.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import Factory
import Alamofire

protocol SyncServiceProtocol {
    func downloadMenuItems() async throws -> [MenuItemDto]
}

final class SyncServiceImpl: SyncServiceProtocol {
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
}
