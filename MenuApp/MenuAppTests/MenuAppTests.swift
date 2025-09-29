//
//  MenuAppTests.swift
//  MenuAppTests
//
//  Created by Nicky Vo on 28/09/2025.
//

import Alamofire
import Factory
import XCTest

@testable import MenuApp

final class MenuAppTests: XCTestCase {
  var itemService: MenuItemService! = nil

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    Container.shared.apiClient.register {
      ApiClient(
        baseUrl: AppConfigs.menuEndpoint
      )
    }

    self.itemService = MenuItemServiceImpl()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testItemsDownload() async throws {
    do {
      let items = try await self.itemService.downloadMenuItems()
      XCTAssert(!items.isEmpty)
    } catch {
      XCTFail("Failed to download items")
    }
  }

  func testLoadItemDetails() async throws {
    do {
      let item = try await self.itemService.loadItemDetails(id: 1)
      // image & descriptions only available on this endpoint
      XCTAssert(item.image?.isEmpty == false)
      XCTAssert(item.description?.isEmpty == false)
    } catch {
      XCTFail("Failed to load item details")
    }
  }

}
