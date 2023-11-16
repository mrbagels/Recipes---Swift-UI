//
//  Client.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

/// Protocol defining the core functionality of a network client for making API requests.
protocol Client {
    /// Loads data from a specified endpoint and decodes it into the specified `Decodable` type.
    ///
    /// - Parameters:
    ///   - endpoint: The `Endpoint` from which to load data.
    /// - Returns: A `Decodable` type object containing the parsed data from the response.
    /// - Throws: `ClientError` representing various possible errors that can occur during the network request.
    func load<T: Decodable>(endpoint: Endpoint) async throws -> T
}

/// Enumeration defining custom errors for the `Client` protocol.
enum ClientError: Error {
    case requestError                   // Error constructing the network request.
    case urlError(Error)                // URL session related error.
    case decodingError(Error)           // Error in decoding the received data.
    case serverError(statusCode: Int)   // HTTP server-side error.
    case unknownError(Error)            // Any other error that is not specifically handled.

    var errorDescription: String {
        switch self {
        case .requestError:                 return "Request could not be constructed."
        case .urlError(let error):          return "URL Error: \(error.localizedDescription)"
        case .decodingError(let error):     return "Decoding Error: \(error.localizedDescription)"
        case .serverError(let statusCode):  return "Server Error: HTTP Status Code \(statusCode)"
        case .unknownError(let error):      return "Unknown Error: \(error.localizedDescription)"
        }
    }
}
