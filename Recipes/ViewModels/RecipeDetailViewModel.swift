//
//  RecipeDetailViewModel.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/15/23.
//

import SwiftUI

@Observable
class RecipeDetailViewModel {
    
    /// Internal recipe reference.
    private let recipe: Recipe

    /// Observable (Published) properties
    
    var name: String {
        return recipe.name ?? K.strings.defaultNavTitle // 'Recipe'
    }
    var imageUrl: URL? {
        return recipe.imageUrl
    }
    var ingredients: [Recipe.Ingredient] {
        return recipe.ingredients
    }
    var instructions: [String] {
        return recipe.instructions
    }

    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
