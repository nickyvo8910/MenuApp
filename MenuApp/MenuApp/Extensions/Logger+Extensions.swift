//
//  File.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import OSLog

extension Logger {
  private static var subsystem = Bundle.main.bundleIdentifier!
  static let network = Logger(subsystem: subsystem, category: "network")
  static let ui = Logger(subsystem: subsystem, category: "ui")
  static let navigation = Logger(subsystem: subsystem, category: "navigation")
  static let popup = Logger(subsystem: subsystem, category: "popup")
}
