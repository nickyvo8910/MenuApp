//
//  CategoryViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import Factory
import OSLog
import UIKit

protocol CategoryViewNavDelegate: AnyObject {
  func onCategoryTapped(courseModel: MenuCourseModel)
}

enum Category: String, CaseIterable {
  case starter
  case main
  case dessert
}

extension CategoryView {
  class CategoryViewModel: BaseViewModel, ObservableObject {
    @Injected(\.itemRepo) var itemRepo: MenuItemsRepository
    weak var navDelegate: CategoryViewNavDelegate?

    var categories: [Category] = Category.allCases
    @Published var selectedCategory: Category = Category.starter

    @Published var isBusy = false
  }
}

extension CategoryView.CategoryViewModel {
  func onCategoryTapped() async {
    guard !isBusy else {
      return
    }
    await MainActor.run {
      self.isBusy = true
    }
    
    do {
      let filteredItems = try await itemRepo.list(category: selectedCategory.rawValue)

      await MainActor.run {
        navDelegate?.onCategoryTapped(
          courseModel: MenuCourseModel(course: selectedCategory.rawValue, items: filteredItems)
        )
        self.isBusy = false
      }
    } catch {
      Logger.database.error(
        "\(#function) - Failed to list items for \(self.selectedCategory.rawValue)"
      )
      await MainActor.run {
        self.isBusy = false
      }
    }
  }
}
