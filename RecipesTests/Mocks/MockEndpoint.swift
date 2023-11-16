//
//  MockEndpoint.swift
//  RecipesTests
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

enum MockEndpoint: Endpoint {
    
    case filter
    case detail
    case invalidUrl
    case invalidData
    
    var baseURL: String {
        return "https://itsnotreal.com/api/v1/"
    }
    
    var mockData: Data? {
        switch self {
        case .filter:       return Mock.filterResponse.data(using: .utf8)
        case .detail:       return Mock.detailResponse.data(using: .utf8)
        case .invalidData:  return Mock.invalidData.data(using: .utf8)
        case .invalidUrl:   return nil
        }
    }
    
    var method: HTTPMethod { return .get }
    var path: String { return "/mockEndpoint" }
    var queryItems: [URLQueryItem]? { return nil }
    
    var url: URL? {
        switch self {
        case .invalidUrl:   return URL(string: "this is_not @ url")
        default:            return URL(string: "https://example.com/mockEndpoint")!
        }
    }
    
    var request: URLRequest? { return url != nil ? URLRequest(url: url!) : nil }
}
