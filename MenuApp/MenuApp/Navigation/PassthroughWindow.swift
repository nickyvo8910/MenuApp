//
//  PassthroughWindow.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import UIKit

class PassthroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if PopupTracker.shared.popups > 0 {
      return super.hitTest(point, with: event)
    } else {
      return nil  // Let touches fall through to windows underneath
    }
  }
}

class PopupTracker {
  static let shared = PopupTracker()
  var popups: Int = 0
}
