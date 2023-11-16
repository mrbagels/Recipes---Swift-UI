//
//  API+Types.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/15/23.
//

import Foundation

/// Often times these wrapper models are created for incoming JSON using a top level object instead of an array; which is common.
/// Standard practice, anecdotally speaking, is to include these wrappers with the model they wrap. This organization makes sense
/// at face value. I prefer to place these one time user API response types within the API itself, clearly illustration its purpase and where it is used.
extension API {
    
    /// Custom wrapper type used for the recipe responses.
    struct RecipeResponseWrapper: Codable, Sequence {
        /// Handle the top level object array from the API response.
        var recipes: [Recipe]
        
        enum CodingKeys: String, CodingKey {
            case recipes = "meals"
        }
        
        func makeIterator() -> Array<Recipe>.Iterator {
            return recipes.makeIterator()
        }
    }
}
