//
//  HomeViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import UIKit

protocol HomeNavDelegate: AnyObject {
  func onMenuItemTapped(menuItem: MenuItem)
}

extension HomeView {
  class HomeViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: HomeNavDelegate?
  }
}
