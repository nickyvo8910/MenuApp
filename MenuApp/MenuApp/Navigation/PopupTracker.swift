//
//  PopupTracker.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import OSLog
import SwiftUI

/// Tracking popup number to work in tandem with PassthroughWindow
class PopupTracker {
  static let shared = PopupTracker()
  var popups: Int = 0
}

struct TrackPopupModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onAppear {
        Logger.popup.info("Popup Added")
        PopupTracker.shared.popups += 1
      }
      .onDisappear {
        Logger.popup.info("Popup Removed")
        PopupTracker.shared.popups -= 1
      }
  }
}

extension View {
  func trackPopup() -> some View {
    modifier(TrackPopupModifier())
  }
}
