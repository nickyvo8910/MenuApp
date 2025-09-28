//
//  HomeView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct HomeView: View {
  @StateObject var viewModel: HomeViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      Text("HomeView")
    }
  }
}

#Preview {
  let vm = HomeView.HomeViewModel()
  HomeView(viewModel: vm)
}
