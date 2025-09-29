//
//  DishDetailsView.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct DishDetailsView: View {
  @StateObject var viewModel: DishDetailsViewModel

  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      HStack{
        Button(action: {
          viewModel.navDelegate?.onDishDetailsBack()
        }, label: {
          Text("<- Back to dishes")
        })
        Spacer()
      }.padding(CommonUIConstants.smallPadding)
      Spacer()
      
      Text("\(viewModel.item.name)")
        .textCase(.uppercase)
        .font(.title)
        .bold()
      Text("\(String(format: "£%.2f", viewModel.item.price))")
        .textCase(.uppercase)
        .font(.title)
      Text("\(viewModel.item.description ?? "Descriptions not available")")
        .font(.title)
        .bold()
      if let imageString = viewModel.item.image,
         let url = URL(string: imageString){
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: CommonUIConstants.dishPictureSize, maxHeight: CommonUIConstants.dishPictureSize)
        } placeholder: {
            ProgressView()
                .frame(width: CommonUIConstants.dishPictureSize, height: CommonUIConstants.dishPictureSize)
        }
        .padding(CommonUIConstants.mediumPadding)
      }else{
        Text("Picture not available")
      }
      
      Spacer()
    }
  }
}

#Preview {
  let vm = DishDetailsView.DishDetailsViewModel(
    item: PreviewValues.items[0]
  )
  DishDetailsView(viewModel: vm)
}
