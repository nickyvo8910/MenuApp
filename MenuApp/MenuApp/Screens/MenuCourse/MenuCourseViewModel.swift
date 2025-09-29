//
//  CategoryViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import Factory
import OSLog
import UIKit

protocol MenuCourseViewNavDelegate: AnyObject {
  func onMenuItemTapped(item: MenuItem)
  func onCourseViewBack()
}

extension MenuCourseView {
  class MenuCourseViewModel: BaseViewModel, ObservableObject {
    @Injected(\.itemService) var itemService: MenuItemService
    weak var navDelegate: MenuCourseViewNavDelegate?

    let courseModel: MenuCourseModel

    @Published var isBusy = false

    init(courseModel: MenuCourseModel) {
      self.courseModel = courseModel
    }
  }
}

extension MenuCourseView.MenuCourseViewModel {
  func onItemTapped(selectedItem: MenuItem) async {
    guard !isBusy else {
      return
    }
    await MainActor.run {
      self.isBusy = true
    }
    do {
      let fetchedItem = try await itemService.loadItemDetails(id: selectedItem.id).toDomainModel()

      await MainActor.run {
        navDelegate?.onMenuItemTapped(item: fetchedItem)
      }
    } catch {
      Logger.network.error(
        "\(#function) - Failed to load item details for \(String(describing: selectedItem))"
      )
      await MainActor.run {
        self.isBusy = false
      }
    }
  }
}
