//
//  ApplicationCoordinator.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
//  Ref: https://github.com/Techne-Coding-Classes/iOS-Advanced-SwiftUI-UIKit-Nav.git

import Combine
import SwiftUI
import UIKit

class ApplicationCoordinator: BaseCoordinator<UINavigationController> {

  private var cancellables = Set<AnyCancellable>()

  let rootViewController: UINavigationController
  let window: UIWindow
  var overlayWindow: UIWindow?

  private override init(presenter: UINavigationController) {
    fatalError("ApplicationCoordinator: This init not used")
  }

  init(window: UIWindow) {
    self.window = window

    rootViewController = UINavigationController()
    rootViewController.isToolbarHidden = true

    super.init(presenter: rootViewController)

    self.window.rootViewController = rootViewController
    self.window.makeKeyAndVisible()

    let overlayWindow = PassthroughWindow(frame: UIScreen.main.bounds)
    overlayWindow.windowLevel = .alert + 1
    overlayWindow.backgroundColor = .clear
    overlayWindow.isHidden = false

    let overlayController = UIHostingController(rootView: WatermarkOverlay())
    overlayController.view.backgroundColor = .clear

    overlayWindow.rootViewController = overlayController
    self.overlayWindow = overlayWindow

    configure()
  }

  override func start() {
    startMain()
  }

}

// MARK: - Configuration
extension ApplicationCoordinator {
  fileprivate func configure() {
  }
}

// MARK: - Starting Flows
extension ApplicationCoordinator {

  fileprivate func startMain() {
    let mainCoordinator = MainCoordinator(presenter: presenter)
    mainCoordinator.delegate = self
    mainCoordinator.start()

    store(coordinator: mainCoordinator)
  }

}

// MARK: - MainCoordinatorDelegate

extension ApplicationCoordinator: MainCoordinatorDelegate {

  func onMainCoordinationComplete(coordinator: MainCoordinator) {
    free(coordinator: coordinator)
  }

}
