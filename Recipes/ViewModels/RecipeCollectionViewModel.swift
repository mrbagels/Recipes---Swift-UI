//
//  RecipeCollectionViewModel.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

@Observable
class RecipeCollectionViewModel {
    
    /// Local instance of API for network requests.
    private var api = API()
    
    /// Observable (Published) properties
    var recipes = [Recipe]()
    var isLoading: Bool = false
    var error: Error?

    func fetchRecipes(for category: String) {
        isLoading = true
        error = nil

        Task {
            do {
                let response = try await api.fetchRecipesAndDetails(category: category)
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    // Filter out recipes with no detail data.
                    strongSelf.recipes = response
                        .filter { $0.ingredients.count > 0 && $0.instructions.count > 0 }
                        .sorted(by: { left, right in
                            guard let left = left.name, let right = right.name else { return false }
                            return left < right
                        })
                    
                    strongSelf.isLoading = false
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.error = error
                    strongSelf.isLoading = false
                }
            }
        }
    }
}
