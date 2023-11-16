//
//  API+Endpoints.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/16/23.
//

import Foundation

// MARK: - MEAL ENDPOINT

/// A representation of various API endpoints for TheMealDB.
enum RecipeEndpoint: Endpoint {
    
    /// Endpoint for filtering meals by category.
    case filter(category: String)
    /// Endpoint for looking up a meal by its ID.
    case lookup(id: Int)
    
    /// The base URL for the API.
    var baseURL: String { return K.strings.recipeServiceBaseUrl }
    
    var method: HTTPMethod {
        switch self {
        case .filter, .lookup:
            return .get
        }
    }

    var path: String {
        switch self {
        case .filter: return "filter.php"
        case .lookup: return "lookup.php"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .filter(let category):  return [URLQueryItem(name: "c", value: category)]
        case .lookup(let id):        return [URLQueryItem(name: "i", value: String(id))]
        }
    }
}
