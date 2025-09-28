//
//  AboutView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct AboutView: View {
  @StateObject var viewModel: AboutViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      Text("About")
      
      Text("Device Model: \(viewModel.deviceModel)")
      Text("OS Version: \(viewModel.osVersion)")
      
      
      Text("https://github.com/nickyvo8910/MenuApp")
    }
  }
}

#Preview {
  let vm = AboutView.AboutViewModel()
  AboutView(viewModel: vm)
}


