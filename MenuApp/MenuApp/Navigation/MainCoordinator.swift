//
//  MainCoordinator.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
//  Ref: https://github.com/Techne-Coding-Classes/iOS-Advanced-SwiftUI-UIKit-Nav.git

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func onMainCoordinationComplete(coordinator: MainCoordinator)
}

enum NavigationBarTag: Int {
    case home
    case about
}

class MainCoordinator: BaseCoordinator<UINavigationController> {
    
    weak var delegate: MainCoordinatorDelegate?
    
    override func start() {
        presenter.setNavigationBarHidden(true, animated: false)
        let tabBarController = configureTabBarCongroller()
        presenter.setViewControllers([tabBarController], animated: true)
    }
    
}

// MARK: - Tab Bar Configuration
private extension MainCoordinator {
    
    func configureTabBarCongroller() -> UITabBarController {
        let homeCoordinator = configureHomeCoordinator()
        let aboutCoordinator = configureAboutCoordinator()
        
        let controllers = [
            homeCoordinator.presenter,
            aboutCoordinator.presenter
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: false)
        
        return tabBarController
    }
    
}

// MARK: - Sub Coordinators
private extension MainCoordinator {
    
    func configureHomeCoordinator() -> HomeCoordinator {
        let flowPresenter = UINavigationController()
        flowPresenter.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: NavigationBarTag.home.rawValue
        )
        
        let coordinator = HomeCoordinator(presenter: flowPresenter)
        coordinator.start()
        
        store(coordinator: coordinator)
        return coordinator
    }
    
    func configureAboutCoordinator() -> AboutCoordinator {
        let flowPresenter = UINavigationController()
        flowPresenter.tabBarItem = UITabBarItem(
            title: "About",
            image: UIImage(systemName: "line.3.horizontal"),
            tag: NavigationBarTag.about.rawValue
        )
        
        let coordinator = AboutCoordinator(presenter: flowPresenter)
        coordinator.start()
        
        store(coordinator: coordinator)
        return coordinator
    }
    
}
