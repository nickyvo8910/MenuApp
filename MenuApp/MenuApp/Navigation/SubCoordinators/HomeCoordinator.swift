//
//  HomeCoordinator.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import OSLog
import SwiftUI
import UIKit

class HomeCoordinator: BaseCoordinator<UINavigationController> {

  override func start() {
    presenter.setNavigationBarHidden(true, animated: false)
    showHomeScreen()
  }
}

// MARK: - Showing Screens
extension HomeCoordinator {
  func showHomeScreen() {
    let viewModel = HomeView.HomeViewModel()
    viewModel.navDelegate = self

    let view = HomeView(viewModel: viewModel)
    let controller = HostingController(rootView: view, viewModel: viewModel)
    presenter.setViewControllers([controller], animated: true)
  }
  
  func showMenuDetails(menuItem: MenuItem) {
    let viewModel = MenuDetailsView.MenuDetailsViewModel(menuItem: menuItem)
    viewModel.navDelegate = self

    let view = MenuDetailsView(viewModel: viewModel)
    let controller = HostingController(rootView: view, viewModel: viewModel)
    controller.title = "MenuDetailsView"
    controller.hidesBottomBarWhenPushed = true
    presenter.pushViewController(controller, animated: true)
  }
}

extension HomeCoordinator: HomeNavDelegate {
  func onMenuItemTapped(menuItem: MenuItem) {
    showMenuDetails(menuItem: menuItem)
  }
}

extension HomeCoordinator: MenuDetailsNavDelegate {
  func onBack() {
    presenter.popToRootViewController(animated: true)
  }
}
