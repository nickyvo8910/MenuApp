//
//  WatermarkOverlay.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import MijickPopups
import SwiftUI

/// Watermark and serve as a holder for MijickPopups popups
struct WatermarkOverlay: View {
  var watermark: String = "Nicky Vo"

  var body: some View {
    ZStack {
      GeometryReader { geometry in
        ZStack {
          // Background banner for the text
          RoundedRectangle(cornerRadius: 10)
            .fill(Color.green.opacity(0.5))
            .frame(width: geometry.size.width, height: 40)
            .rotationEffect(.degrees(45))

          // The text itself
          Text(watermark.capitalized)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .rotationEffect(.degrees(45))
        }
        .position(x: geometry.size.width * 0.88, y: geometry.size.height * 0.08)
      }
      .edgesIgnoringSafeArea(.all)
    }
    .registerPopups()
  }
}
