//
//  Constants.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/15/23.
//

import  SwiftUI
 
struct K {
    
    // MARK: - LAYOUT
    
    /// Store all layout related constants.
    struct layout {
        // Spacing
        static let smallSpacing = 8.0
        static let mediumSpacing = 16.0
        static let largeSpacing = 32.0
        
        // Padding
        static let xSmallPadding = 4.0
        static let smallPadding = 16.0
        static let mediumPadding = 16.0
        static let largePadding = 32.0
        
        static let ingredientImageHeight = 32.0
    }
    
    // MARK: - STRINGS
    
    /// Store all constant string values.
    struct strings {
        static let ingredientsTitle = "Ingredients"
        static let instructionsTitle = "Instructions"
        static let defaultNavTitle = "Recipes"
        static let defaultCategory = "dessert"
        
        static let networkErrorText = "Network error occurred while fetching data."
        static let decodingErrorText = "Error occurred while decoding the data."
        static let networkRecoveryText = "Check your internet connection and try again."
        static let decodingRecoveryText = "There was an issue decoding the data. Please try again later."
        
        static let errorTitle = "Error"
        static let errorButtonTitle = "OK"
        static let errorDefaultDescription = "An unknown error occurred"
    
        static let recipeServiceBaseUrl = "https://themealdb.com/api/json/v1/1/"
        static let ingredientImageBaseUrl = "https://themealdb.com/images/ingredients/"
    }
    
    // MARK: - SYMBOLS
    
    /// Store all constant symbols (or images)
    struct symbols {
        static let ingredientsIcon = "checklist"
        static let instructionsIcon = "list.number"
        static let defaultImageIcon = "arrow.down.circle.dotted"
    }
    
    // MARK: - METHODS
    
    /// Convenience function for unwrapping display strings.
    static func unwrapped(_ string: String?, default defaultString: String = "--") -> String {
        return string ?? defaultString
    }
}
