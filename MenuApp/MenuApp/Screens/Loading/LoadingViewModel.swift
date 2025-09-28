//
//  LoadingNavDelegate.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import OSLog
import SwiftUI
import Combine

protocol LoadingNavDelegate: AnyObject {
  func onLoadingCompleted()
}

extension LoadingView.LoadingViewModel {
  func onLoadingCompleted() {
    navDelegate?.onLoadingCompleted()
  }
}

enum LoadingError: LocalizedError {
  case noInternet
  case unauthorised
  case other

  var errorDescription: String {
    switch self {
    case .noInternet:
      return "No Internet Connection."
    case .unauthorised:
      return "Issue with endpoint permissions."
    case .other:
      return "Failed to download data from endpoint."
    }
  }
}

extension LoadingView { 
  class LoadingViewModel: BaseViewModel, ObservableObject {
    weak var navDelegate: LoadingNavDelegate?
    private var cancellables: [AnyCancellable] = []
    
    @Published var isBusy: Bool = true
    
    @Published var loadingError: LoadingError?
    
    
    override init() {
      super.init()
      
      cancellables.append(
        $isBusy
          .sink { newValue in
            if !newValue {
              self.onLoadingCompleted()
            }
          }
      )
    }
    
    deinit {
      for cancellable in cancellables {
        cancellable.cancel()
      }
    }
    
    func onViewInit() async {
      
      try? await Task.sleep(nanoseconds: 500000000)
      // Loading complete
      await MainActor.run {
        self.isBusy = false
      }
      
    }
    
  }
}
