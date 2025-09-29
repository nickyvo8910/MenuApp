//
//  AboutViewModel.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import UIKit

protocol AboutNavDelegate: AnyObject {
}

extension AboutView {
  class AboutViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: AboutNavDelegate?

    var deviceModel: String = {
      return UIDevice.current.model
    }()

    var osVersion: String = {
      return UIDevice.current.systemVersion
    }()
  }
}
