//
//  Endpoint.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

/// Protocol defining the requirements for Client endpoints.
protocol Endpoint {
    /// The base URL to be used by all endpoints.
    var baseURL: String { get }
    /// The HTTP method to be used for the request.
    var method: HTTPMethod { get }
    /// The specific path for the endpoint.
    var path: String { get }
    /// The query items required for the endpoint URL.
    var queryItems: [URLQueryItem]? { get }
    /// Constructs the full URL for the endpoint.
    var url: URL? { get }
    /// Creates a URLRequest configured for the specific endpoint case.
    var request: URLRequest? { get }
}

extension Endpoint {
    
    /// Default implementation for query items.
    var queryItems: [URLQueryItem]? { return nil }
    
    /// Default implementation for constructing a 'URL' object.
    var url: URL? {
        var components = URLComponents(string: self.baseURL)
        components?.path += self.path
        components?.queryItems = self.queryItems
        return components?.url
    }

    /// Default implementation for constructing a 'URLRequest' object.
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

// MARK: - Custom Types

/// Defines the HTTP methods used in network requests.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
