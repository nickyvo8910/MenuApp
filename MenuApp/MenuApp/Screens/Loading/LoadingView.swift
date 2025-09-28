//
//  LoadingView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct LoadingView: View { 
  @StateObject var viewModel: LoadingViewModel
  var body: some View {
    ZStack {
      Color.accent
        .ignoresSafeArea()
      VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
       
        // Start of loading form
        VStack(alignment: .center, spacing: CommonUIConstants.mediumPadding) {
          Spacer()

          LoadingCircle(strokeWidth: 10, height: 100)

          Text("Loading")
            .foregroundStyle(Color.colorOffWhite)
            .padding(.bottom, CommonUIConstants.mediumPadding)

          Spacer()
        }
      }
      .padding(.top, CommonUIConstants.largePadding)
      .padding([.leading, .trailing, .bottom], CommonUIConstants.mediumPadding)

    }.ignoresSafeArea()
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .task {
        await viewModel.onViewInit()
      }
  }
}

#Preview {
  NavigationStack {
    LoadingView(viewModel: .init())
  }
}
