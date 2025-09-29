//
//  MenuDetailsViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import UIKit

protocol DishDetailsNavDelegate: AnyObject {
  func onDishDetailsBack()
}

extension DishDetailsView {
  class DishDetailsViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: DishDetailsNavDelegate?
    var item: MenuItem
    
    init(item: MenuItem) {
      self.item = item
    }
  }
}
