//
//  API.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/15/23.
//

import Foundation

/// Basic API class for processing network requests via 'MealEndpoint' objects.
class API {
    
    /// Private local instance of the default URLSession client.
    private let client: Client = DefaultClient()
    
    /// Fetch meals from TheMealDB based on the provided category.
    /// 
    /// - Parameter category: the category to filter results by.
    /// - Returns: A 'MealResponse' object.
    func fetchRecipes(category: String) async throws -> [Recipe] {
        let responseWrapper: RecipeResponseWrapper = try await client.load(endpoint: RecipeEndpoint.filter(category: category))
        return responseWrapper.recipes
    }
    
    /// Fetch meal details from TheMealDB based on the provided meal ID.
    ///
    /// - Parameter id: the id of the meal details to be fetched.
    /// - Returns: A 'MealResponse' object.
    func fetchRecipeDetails(for id: Int) async throws -> Recipe {
        
        let responseWrapper: RecipeResponseWrapper = try await client.load(endpoint: RecipeEndpoint.lookup(id: id))
        guard let recipe = responseWrapper.recipes.first else {
            // Throw an error if no recipe is found on the successful load response.
            throw APIError.decodingError
        }
        return responseWrapper.recipes.first!
    }
    
    /// Fetch detailed recipes for each meal in a category concurrently.
    ///
    /// - Parameter category: The category to filter results by.
    /// - Returns: An array of detailed meal recipes.
    func fetchRecipesAndDetails(category: String) async throws -> [Recipe] {
        
        // Fetch the list of recipes.
        let recipes = try await fetchRecipes(category: category)
        var detailedRecipes: [Recipe] = []

        try await withThrowingTaskGroup(of: Recipe.self) { group in
            for recipe in recipes {
                group.addTask {
                    return try await self.fetchRecipeDetails(for: recipe.id)
                }
            }
            for try await recipe in group {
                detailedRecipes.append(recipe)
            }
        }
        return detailedRecipes
    }
}

// MARK: - CUSTOM ERRORS

enum APIError: LocalizedError {
    
    /// Networking error durring request.
    case networkError
    /// Decoding error durring request.
    case decodingError
    
    /// A description string for each error type.
    var errorDescription: String? {
        switch self {
        case .networkError: return K.strings.networkErrorText
        case .decodingError: return K.strings.decodingErrorText
        }
    }

    // Provide a recovery suggestion for each error type.
    var recoverySuggestion: String? {
        switch self {
        case .networkError: return K.strings.networkRecoveryText
        case .decodingError: return K.strings.decodingRecoveryText
        }
    }
}

