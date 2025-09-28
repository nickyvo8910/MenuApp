//
//  MenuAppTests.swift
//  MenuAppTests
//
//  Created by Nicky Vo on 28/09/2025.
//

import XCTest
import Alamofire
import Factory

@testable import MenuApp

final class MenuAppTests: XCTestCase {
  var syncService: SyncService! = nil

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    Container.shared.apiClient.register { ApiClient(
      baseUrl: AppConfigs.menuEndpoint
    ) }
    
    self.syncService = SyncServiceImpl()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testItemsDownload() async throws {
    do {
      let items = try await self.syncService.downloadMenuItems()
      XCTAssert(!items.isEmpty)
    }  catch {
      XCTFail("Failed to download items")
    }
  }
  
  func testLoadItemDetails() async throws {
    do {
      let item = try await self.syncService.loadItemDetails(id: 1)
      // image & descriptions only available on this endpoint
      XCTAssert(item.image?.isEmpty == false)
      XCTAssert(item.description?.isEmpty == false)
    }  catch {
      XCTFail("Failed to load item details")
    }
  }

}
