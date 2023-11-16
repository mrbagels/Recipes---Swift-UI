//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/15/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
    /// An observable 'RecipeDetailViewModel' object.
    @State var viewModel: RecipeDetailViewModel
    
    init(recipe: Recipe) {
        self.viewModel = RecipeDetailViewModel(recipe: recipe)
    }
    
    var body: some View {
        ScrollView {
            // Header view with feature image.
            HeaderSection(imageUrl: viewModel.imageUrl, title: viewModel.name)
            // Content view with ingredient and instructions lists.
            ContentSection(ingredients: viewModel.ingredients, instructions: viewModel.instructions)
        }
        .navigationBarTitle(viewModel.name, displayMode: .inline)
    }
}

// MARK: - CUSTOM VIEWS

/// Composition view for the header section.
struct HeaderSection: View {
    
    /// The URL for the image to display.
    let imageUrl: URL?
    /// The title text to display.
    let title: String
    
    var body: some View {
        ZStack(alignment: .center) {
            PhotoBackground(imageUrl: imageUrl)
                .aspectRatio(contentMode: .fill)
            
            Text(title)
                .font(.title).bold()
                .foregroundStyle(.overlayFont)
                .multilineTextAlignment(.center)
                .padding()
                .background(.overlayBackground, in: Capsule())
        }
        .clipped()
    }
}

/// Composition view for the body section.
struct ContentSection: View {
    
    /// Local reference to the ingrendients.
    let ingredients: [Recipe.Ingredient]
    /// Local reference to the instrcutions.
    let instructions: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: K.layout.largeSpacing) {
            IngredientsListView(ingredients: ingredients)
            InstructionsListView(instructions: instructions)
        }
        .padding(K.layout.largePadding)
    }
}

/// Composition view for the list of ingredients and their measurements.
struct IngredientsListView: View {

    // Local property for data to display.
    var ingredients: [Recipe.Ingredient]
    
    var body: some View {
        VStack(alignment: .center, spacing: K.layout.largeSpacing) {
            Label(K.strings.ingredientsTitle, systemImage: K.symbols.ingredientsIcon)
                .font(.title)
                .foregroundStyle(.primaryText)
            
            VStack(alignment: .leading, spacing: K.layout.smallSpacing) {
                ForEach(ingredients) { ingredient in
                    IngredientRow(ingredient: ingredient)
                }
            }
        }
    }
}

/// Composition view for a row item in the IngredientListView.
struct IngredientRow: View {
    
    /// Local reference to the ingredient data.
    let ingredient: Recipe.Ingredient
    
    var body: some View {
        HStack(spacing: K.layout.smallSpacing) {
            AsyncImage(url: ingredient.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: K.layout.ingredientImageHeight)
            } placeholder: {
                Image(systemName: K.symbols.defaultImageIcon)
            }
            
            Text("\(ingredient.name):")
                .font(.headline)
                .foregroundStyle(.primaryText)
                
            Spacer()
            
            Text("\(ingredient.measurement)")
                .font(.body)
                .foregroundStyle(.secondaryText)
        }
        
        // Add a small divider below each ingredient.
        Divider()
    }
}

/// Composition view for the list of instructions to follow.
struct InstructionsListView: View {
    
    // Local reference for direction objects to be displayed.
    var instructions: [String]
    
    var body: some View {
        VStack(alignment: .center, spacing: K.layout.largeSpacing) {
            Label(K.strings.instructionsTitle, systemImage: K.symbols.instructionsIcon)
                .font(.title)
                .foregroundStyle(.primaryText)
            
            VStack(alignment: .leading, spacing: K.layout.mediumSpacing) {
                ForEach(instructions.indices, id: \.self) { index in
                    InstructionRow(instruction: instructions[index])
                }
            }
        }
    }
}

/// Composition view for a row item in the IngredientListView.
struct InstructionRow: View {
    
    /// Local reference to the instruction string data.
    let instruction: String
    
    var body: some View {
        HStack() {
            Text(instruction)
                .font(.body)
                .foregroundStyle(.secondaryText)
        }
        
        // Add a divider with a large padding for a smaller separator.
        Divider()
            .padding(.horizontal, K.layout.largePadding)
    }
}
