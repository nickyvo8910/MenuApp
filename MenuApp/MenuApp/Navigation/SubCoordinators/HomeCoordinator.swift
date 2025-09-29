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
    let viewModel = CategoryView.CategoryViewModel()
    viewModel.navDelegate = self

    let view = CategoryView(viewModel: viewModel)
    let controller = HostingController(rootView: view, viewModel: viewModel)
    presenter.setViewControllers([controller], animated: true)
  }

  func showMenuCourse(courseModel: MenuCourseModel) {
    let viewModel = MenuCourseView.MenuCourseViewModel(courseModel: courseModel)
    viewModel.navDelegate = self

    let view = MenuCourseView(viewModel: viewModel)
    let controller = HostingController(rootView: view, viewModel: viewModel)
    controller.title = "MenuCourseView"
    controller.hidesBottomBarWhenPushed = true
    presenter.pushViewController(controller, animated: true)
  }

  func showMenuDetails(item: MenuItem) {
    let viewModel = DishDetailsView.DishDetailsViewModel(item: item)
    viewModel.navDelegate = self

    let view = DishDetailsView(viewModel: viewModel)
    let controller = HostingController(rootView: view, viewModel: viewModel)
    controller.title = "DishDetailsView"
    controller.hidesBottomBarWhenPushed = true
    presenter.pushViewController(controller, animated: true)
  }
}

extension HomeCoordinator: CategoryViewNavDelegate {
  func onCategoryTapped(courseModel: MenuCourseModel) {
    showMenuCourse(courseModel: courseModel)
  }
}

extension HomeCoordinator: MenuCourseViewNavDelegate {
  func onCourseViewBack() {
    presenter.popViewController(animated: true)
  }

  func onMenuItemTapped(item: MenuItem) {
    showMenuDetails(item: item)
  }
}

extension HomeCoordinator: DishDetailsNavDelegate {
  func onDishDetailsBack() {
    presenter.popViewController(animated: true)
  }

  func onBack() {
    presenter.popToRootViewController(animated: true)
  }
}
