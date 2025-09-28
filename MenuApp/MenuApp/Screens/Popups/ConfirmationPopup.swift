//
//  ConfirmationPopup.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//


import MijickPopups
import SwiftUI

struct ConfirmationPopup: CenterPopup {
  let title: String
  let message: String
  let confirm: String
  var onConfirm: (() -> Void)

  var body: some View {
    VStack(alignment: .center, spacing: CommonUIConstants.vstackSpacing) {
      Text(title)
        .multilineTextAlignment(.center)
      Text(message)
        .multilineTextAlignment(.center)
      Button(
        action: {
          Task {
            await dismissLastPopup()
            onConfirm()
          }
        },
        label: {
          Text(confirm).frame(maxWidth: .infinity)
        }
      ).buttonStyle(.automatic)
    }.padding()
      .trackPopup()
  }
}

#Preview {
  ZStack {}.registerPopups().onAppear {
    Task {
      await ConfirmationPopup(
        title: "Tile",
        message: "Message",
        confirm: "Ok",
        onConfirm: {}
      ).present()
    }
  }
}
