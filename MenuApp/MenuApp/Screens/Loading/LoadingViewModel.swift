//
//  LoadingNavDelegate.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//

import Combine
import Factory
import OSLog
import SwiftUI

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
    @Injected(\.syncService) var syncService: SyncService
    @Injected(\.itemRepo) var itemRepo: MenuItemsRepository

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

    func trySyncData() async {
      await syncData()

      if loadingError != nil {
        await ConfirmationPopup(
          title: "Data Sync Failed",
          message: " \(loadingError?.errorDescription ?? "") - Please try again",
          confirm: "OK",
          onConfirm: {

          }
        ).present()

      } else {
        // Loading complete
        await MainActor.run {
          self.isBusy = false
        }
      }
    }

    func syncData() async {
      await MainActor.run {
        self.loadingError = nil
      }
      #if DEBUG
        try? await Task.sleep(nanoseconds: 500_000_000)  // Delay for debug demo
      #endif

      do {
        let response = try await syncService.downloadMenuItems()

        if response.isEmpty {
          await MainActor.run {
            loadingError = .other
          }
        } else {
          // Mapping reponse items to DomainModels then init the database replacement process.
          // This allows data refresh on app start
          try await itemRepo.replaceFromList(items: response.map({ $0.toDomainModel() }))
          Logger.database.info("\(#function) - Replaced items with new data from endpoint.")
        }

      } catch let error as ApiError {
        switch error {
        case .noConnection:
          await MainActor.run {
            loadingError = .noInternet
          }
          Logger.network.error("\(#function) - noInternet.")
        case .unauthorized:
          await MainActor.run {
            loadingError = .unauthorised
          }
          Logger.network.error("\(#function) - unauthorised.")
        default:
          await MainActor.run {
            loadingError = .other
          }
          Logger.network.error("\(#function) - other api error: \(error)")
        }
      } catch {
        await MainActor.run {
          loadingError = .other
        }
        Logger.network.error("\(#function) - other network error.")
      }
    }
  }
}
