//
//  CourseView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct CourseView: View {
  @StateObject var viewModel: CourseViewModel

  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      Text("Select A Course")
        .font(.title)
        .bold()
      categoryCarousel
      Text("Swipe for more ->")
    }
  }

  private var categoryCarousel: some View {
    let view = VStack(spacing: 0) {
      TabView(selection: $viewModel.selectedCourse) {
        ForEach(viewModel.courses, id: \.self) { categoryString in
          VStack {
            Text("\(categoryString)")
              .textCase(.uppercase)
              .font(.title)
              .bold()
          }
          .tag(categoryString)
          .padding(CommonUIConstants.mediumPadding)
          .onTapGesture {
            Task {
              await viewModel.onCourseTapped()
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
  var vm = CourseView.CourseViewModel()
  CourseView(viewModel: vm)
}
