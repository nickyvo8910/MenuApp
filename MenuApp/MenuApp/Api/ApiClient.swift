//
//  ApiClient.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import Alamofire
import Foundation
import OSLog

final class ApiClient {
  let baseUrl: String

  init(baseUrl: String) {
    self.baseUrl = baseUrl
  }

  func handleResponse<Value>(response: DataResponse<Value, AFError>) throws -> Value {
    switch response.result {
    case .success(let value):
      return value
    case .failure(let error):
      Logger.network.error(
        "\(#function) - API request failure - \(String(describing: response.response))"
      )
      throw mapAPIError(error, response: response.response)
    }
  }

  private func mapAPIError(_ error: AFError, response: HTTPURLResponse?) -> ApiError {
    if let urlError = error.underlyingError as? URLError {
      switch urlError.code {
      case .notConnectedToInternet:
        return .noConnection
      case .timedOut:
        return .timeout
      default:
        Logger.network.error("\(#function) - urlError - \(String(describing: urlError.code))")
        return .networkError(urlError.localizedDescription)
      }
    }
    if let statusCode = response?.statusCode {
      switch statusCode {
      case 400:
        return .badRequest(error.localizedDescription)
      case 401:
        return .unauthorized
      case 404:
        return .notFound
      default:
        return .invalidStatusCode(statusCode)
      }
    } else if error.isResponseSerializationError {
      return .jsonDecoding
    } else {
      Logger.network.error("\(#function) - error - \(error.localizedDescription)")
      return .responseError(error.localizedDescription)
    }
  }
}
