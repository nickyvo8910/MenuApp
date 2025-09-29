//
//  HostingController.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import SwiftUI
import UIKit

class HostingController<Content: View, VM: BaseViewModel>: UIHostingController<Content> {

  var viewModel: VM

  init(rootView: Content, viewModel: VM) {
    self.viewModel = viewModel
    super.init(rootView: rootView)
    viewModel.hostingController = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .colorOffWhite
  }

  required init?(coder aDecoder: NSCoder) {
    preconditionFailure("init(coder:) not implemented")
  }

}
