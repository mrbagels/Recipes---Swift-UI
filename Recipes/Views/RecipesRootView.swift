//
//  ContentView.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/14/23.
//

import SwiftUI

struct RecipesRootView: View {
    
    var body: some View {
        // Hard code the category for the sake of this demo.
        let category: String = K.strings.defaultCategory
        
        NavigationView {
            RecipeCollectionView(category: category)
                .navigationBarTitle(category.capitalized, displayMode: .large)
        }
    }
}

#Preview {
    RecipesRootView()
}
