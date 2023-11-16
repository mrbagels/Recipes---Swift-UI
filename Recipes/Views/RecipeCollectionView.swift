//
//  RecipeListView.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/15/23.
//

import SwiftUI

struct RecipeCollectionView: View {
    
    // Create a state property for our view model.
    @State var viewModel = RecipeCollectionViewModel()
    // State property for managing errors.
    @State private var error: APIError? = nil
    
    let category: String
    
    // Define the 2 colum grid layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            RecipeGridView(recipes: viewModel.recipes, columns: columns) {
                viewModel.fetchRecipes(for: category)
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { self.error != nil },
            set: { _ in self.error = nil }
        ), content: {
            if let error = error {
                return Alert(title: Text(K.strings.errorTitle),
                             message: Text(error.errorDescription ?? K.strings.errorDefaultDescription),
                             dismissButton: .default(Text(K.strings.errorButtonTitle)))
            } else {
                return Alert(title: Text(K.strings.errorTitle))
            }
        })
    }
}

#Preview {
    RecipeCollectionView(category: "dessert")
}

// MARK: - CUSTOM VIEWS

struct RecipeGridView: View {
    
    var recipes: [Recipe]
    var columns: [GridItem]
    var fetchRecipes: () -> Void

    var body: some View {
        GridView(recipes: recipes, columns: columns)
            .padding()
            .onAppear(perform: fetchRecipes)
    }
}

struct GridView: View {
    
    /// Local reference to recipes.
    let recipes: [Recipe]
    /// Local reference for column/grid layout.
    let columns: [GridItem]
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 2) {
          ForEach(recipes) { recipe in
              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                  // I was going to use 'thumbnailUrl' but I didn't like the quality :)
                  RecipeGridCell(title: K.unwrapped(recipe.name), imageUrl: recipe.imageUrl)
                      .padding(K.layout.xSmallPadding)
              }
          }
        }
    }
}

struct RecipeGridCell: View {
    
    /// Local reference for the title string.
    var title: String
    /// The image URL to load asynchrinously
    var imageUrl: URL?
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                PhotoBackground(imageUrl: imageUrl)
                Caption(title: title)
            }
        }
        .cornerRadius(12)
        .clipped()
    }
}

/// Composition view for a photo background with asyn image loading.
struct PhotoBackground: View {
    
    /// The URL to load the image from.
    var imageUrl: URL?
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image.resizable()
        } placeholder: {
            Color.gray
                .opacity(0.3)
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Image(systemName: K.symbols.defaultImageIcon)
                        .symbolEffect(.bounce.byLayer, value: true)
                )
        }
        .aspectRatio(contentMode: .fit)
    }
}

/// Composition view for a photo caption.
struct Caption: View {
    
    /// Local reference to the title to be displayed.
    var title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(.overlayFont)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Rectangle().fill(.overlayBackground))
    }
}
