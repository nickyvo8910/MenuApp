//
//  CategoryView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct CategoryView: View {
  @StateObject var viewModel: CategoryViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      Text("Select A Course")
        .font(.title)
        .bold()
      categoryCarousel
      Text("Swipe for more ->")
    }.navigationTitle("Select A Course")
  }
  
  private var categoryCarousel: some View {
    let view = VStack(spacing: 0) {
      TabView(selection: $viewModel.selectedCategory) {
        ForEach(viewModel.categories, id: \.self) { categoryString in
          VStack{
            Text("\(categoryString)")
              .textCase(.uppercase)
              .font(.title)
              .bold()
          }
          .tag(categoryString)
          .padding(CommonUIConstants.mediumPadding)
            .onTapGesture {
              Task{
                await viewModel.onCategoryTapped()
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
  var vm = CategoryView.CategoryViewModel()
  CategoryView(viewModel: vm)
}
