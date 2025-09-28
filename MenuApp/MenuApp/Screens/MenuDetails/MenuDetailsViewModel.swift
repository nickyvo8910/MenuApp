//
//  MenuDetailsViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import UIKit

protocol MenuDetailsNavDelegate: AnyObject {
  func onBack()
}

extension MenuDetailsView {
  class MenuDetailsViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: MenuDetailsNavDelegate?
    var menuItem: MenuItem
    
    init(menuItem: MenuItem) {
      self.menuItem = menuItem
    }
  }
}
