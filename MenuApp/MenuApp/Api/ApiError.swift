//
//  ApiError.swift
//  MenuApp
//
//  Created by Nicky Vo on 28/09/2025.
//
import Foundation

enum ApiError: Error, Equatable {
    case unauthorized
    case invalidStatusCode(Int)
    case badRequest(String)
    case unprocessableEntity(String)
    case notFound
    case noConnection
    case timeout
    case jsonDecoding
    case responseError(String)
    case networkError(String)
    case invalidURL
    case invalidParams
    case invalidQuery
    case noData
    case notImplemented
}

