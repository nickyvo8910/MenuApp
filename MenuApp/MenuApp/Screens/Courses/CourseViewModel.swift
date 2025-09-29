//
//  CourseViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import Factory
import OSLog
import UIKit

protocol CourseViewNavDelegate: AnyObject {
  func onCourseTapped(courseModel: MenuCourseModel)
}

enum Course: String, CaseIterable {
  case starter
  case main
  case dessert
}

extension CourseView {
  class CourseViewModel: BaseViewModel, ObservableObject {
    @Injected(\.itemRepo) var itemRepo: MenuItemsRepository
    weak var navDelegate: CourseViewNavDelegate?

    var courses: [Course] = Course.allCases
    @Published var selectedCourse: Course = Course.starter

    @Published var isBusy = false
  }
}

extension CourseView.CourseViewModel {

  func onCourseTapped() async {
    // Is busy to avoid spamming
    guard !isBusy else {
      return
    }
    await MainActor.run {
      self.isBusy = true
    }

    do {
      // Filtering items that match the selected course
      let filteredItems = try await itemRepo.list(category: selectedCourse.rawValue)

      await MainActor.run {
        // Building model and navigate
        navDelegate?.onCourseTapped(
          courseModel: MenuCourseModel(course: selectedCourse.rawValue, items: filteredItems)
        )
        self.isBusy = false
      }
    } catch {
      Logger.database.error(
        "\(#function) - Failed to list items for \(self.selectedCourse.rawValue)"
      )
      await MainActor.run {
        self.isBusy = false
      }
    }
  }
}
