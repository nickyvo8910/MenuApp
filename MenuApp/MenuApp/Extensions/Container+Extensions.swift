//
//  Container+Extensions.swift
//  ReaScan
//
//  Created by Nicky Vo on 12/02/2025.
//

import Factory
import Foundation

extension Container {

  var apiClient: Factory<ApiClient> {
    self { ApiClient(baseUrl: AppConfigs.menuEndpoint) }.singleton
  }
  
  var syncService: Factory<SyncService>{
    self { SyncServiceImpl() }.singleton
  }
  
  var itemRepo: Factory<MenuItemsRepository> {
    self { CoreDataItemsRepository(context: CoreDataController.shared.context) }
  }
}
