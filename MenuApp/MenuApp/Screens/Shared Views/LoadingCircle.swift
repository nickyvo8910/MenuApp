//
//  LoadingCircle.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI

struct LoadingCircle: View {
  @State private var isLoading = false

  var strokeColor: Color = .white
  var strokeWidth: CGFloat = 2
  var padding: CGFloat = 20

  var height: CGFloat = 46

  var body: some View {
    Circle()
      .trim(from: 0, to: 0.7)
      .stroke(
        strokeColor,
        style: StrokeStyle(
          lineWidth: strokeWidth,
          lineCap: .round,
          lineJoin: .round
        )
      )
      .frame(width: height - padding, height: height - padding)
      .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
      .task {
        withAnimation(Animation.default.repeatForever(autoreverses: false)) {
          self.isLoading = true
        }
      }
  }
}

#Preview {
  ZStack {
    Color.red
    LoadingCircle()
  }

}
