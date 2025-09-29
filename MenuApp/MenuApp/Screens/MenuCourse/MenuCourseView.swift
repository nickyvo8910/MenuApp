//
//  MenuCourseView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct MenuCourseView: View {
  @StateObject var viewModel: MenuCourseViewModel

  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      Text("\(viewModel.courseModel.course) Dishes")
        .font(.title)
        .bold()
      Text("Select A Dish")
        .font(.title)
      itemCarousel
      Text("Swipe for more ->")
    }.navigationTitle("Select A Dish")
  }

  private var itemCarousel: some View {
    let view = VStack(spacing: 0) {
      TabView {
        ForEach(viewModel.courseModel.items, id: \.id) { item in
          VStack {
            Text("\(item.name)")
              .textCase(.uppercase)
              .font(.title)
              .bold()
            Text("\(String(format: "£%.2f", item.price))")
              .textCase(.uppercase)
              .font(.title)
          }
          .tag(item)
          .padding(CommonUIConstants.mediumPadding)
          .onTapGesture {
            Task {
              await viewModel.onItemTapped(selectedItem: item)
            }
          }
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .always))
    }
    return view
  }
}

#Preview {
  let items = PreviewValues.items
  let vm = MenuCourseView.MenuCourseViewModel(
    courseModel: MenuCourseModel(course: "Test", items: items)
  )
  MenuCourseView(viewModel: vm)
}
