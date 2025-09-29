//
//  AboutCoordinator.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import OSLog
import SwiftUI
import UIKit

class AboutCoordinator: BaseCoordinator<UINavigationController> {

  override func start() {
    presenter.setNavigationBarHidden(true, animated: false)
    showAboutScreen()
  }
}

// MARK: - Showing Screens
extension AboutCoordinator {
  func showAboutScreen() {
    let viewModel = AboutView.AboutViewModel()
    viewModel.navDelegate = self

    let view = AboutView(viewModel: viewModel)
    let controller = HostingController(rootView: view, viewModel: viewModel)
    presenter.setViewControllers([controller], animated: true)
  }
}

extension AboutCoordinator: AboutNavDelegate {

}
