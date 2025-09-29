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
    showCourseSelection()
  }
}

// MARK: - Showing Screens
extension HomeCoordinator {
  func showCourseSelection() {
    let viewModel = CourseView.CourseViewModel()
    viewModel.navDelegate = self

    let view = CourseView(viewModel: viewModel)
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

extension HomeCoordinator: CourseViewNavDelegate {
  func onCourseTapped(courseModel: MenuCourseModel) {
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
}
