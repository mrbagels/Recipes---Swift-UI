//
//  Recipe.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

// MARK: - Recipe

struct Recipe: Codable, Identifiable {
        
    /// Custom internal type for JSON transformation.
    struct Ingredient: Codable, Identifiable {
        /// Required for Identifiable conformance.
        var id: UUID = UUID()
        /// Represents "strIngredient"
        var name: String
        /// Represents "strMeasurement"
        var measurement: String
        
        /// Custom property for the ingredient small image.
        var imageUrl: URL? {
            return URL(string: "\(K.strings.ingredientImageBaseUrl)\(name)-Small.png")
        }
    }
    
    /// Represents "idMeal"
    var id: Int = -1
    /// Represents "strMeal"
    let name: String?
    /// Represents "strDrinkAlternate"
    let drinkAlternate: String?
    /// Represents "strCategory"
    let category: String?
    /// Represents "strArea"
    let area: String?
    /// Represents "strTags"
    let tags: String?
    /// Represents "strMealThumb"
    let imageUrl: URL?
    /// Represents "strYoutube"
    let youtubeUrl: URL?
    /// Represents "strSource"
    let sourceUrl: URL?
    /// Represents "strImageSource"
    let imageSourceUrl: URL?
    /// Represents "strInstructions"
    let instructionsString: String?
    
    // Custom properties.
    
    /// Custom Ingredient type array
    var ingredients: [Ingredient] = []
    /// Custom array of NumberedInstruction types for cooking instructions.
    var instructions: [String] = []
    /// Custom URL for thumbnail.
    var thumbnailUrl: URL?
        
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructionsString = "strInstructions"
        case tags = "strTags"
        case imageURL = "strMealThumb"
        case youtubeURL = "strYoutube"
        case sourceURL = "strSource"
        case imageSourceURL = "strImageSource"
        
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngrediente16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
    }
    
    // Equatable conformance.
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - DECODING

extension Recipe {
    
    // Implement the custom decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageURL).flatMap(URL.init)
        youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeURL).flatMap(URL.init)
        sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceURL).flatMap(URL.init)
        imageSourceUrl = try container.decodeIfPresent(String.self, forKey: .imageSourceURL).flatMap(URL.init)
        instructionsString = try container.decodeIfPresent(String.self, forKey: .instructionsString)

        // Custom decoding.
        
        id = try decodeId(from: container)
        ingredients = try decodeIngredients(from: container)
        instructions = try parseInstructions(from: instructionsString)
        thumbnailUrl = constructThumbnailUrl(from: imageUrl)
    }
    
    // MARK: DECODER HELPERS
    
    private func decodeId(from container: KeyedDecodingContainer<CodingKeys>) throws -> Int {
        let idString = try container.decode(String.self, forKey: .id)
        // Transform 'id' from String to Int
        guard let idInt = Int(idString) else {
            throw DecodingError.dataCorruptedError(forKey: .id, 
                                                   in: container,
                                                   debugDescription: "ID is not an integer")
        }
        return idInt
    }
    
    private func decodeIngredients(from container: KeyedDecodingContainer<CodingKeys>) throws -> [Ingredient] {
        // Local variable for storing parsed ingredients to return.
        var decodedIngredients = [Ingredient]()
        for index in 1...20 {
            if  // Dynamically create the keys and decode available data.
                let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)"),
                let measureKey = CodingKeys(stringValue: "strMeasure\(index)"),
                let ingredientName = try container.decodeIfPresent(String.self, forKey: ingredientKey),
                !ingredientName.isEmpty,
                let measurement = try container.decodeIfPresent(String.self, forKey: measureKey)
            {
                // Everything checks out; add it as an indredient with the relevant data.
                let ingredient = Ingredient(name: ingredientName, measurement: measurement)
                decodedIngredients.append(ingredient)
            }
        }
        // Pass along the decoded ingredients, if any.
        return decodedIngredients
    }
    
    private func parseInstructions(from instructionsString: String?) throws -> [String] {
        return instructionsString?
            .components(separatedBy: "\r\n") // Separates the steps based on new line.
            .compactMap { $0.isEmpty ? nil : $0 } // Removes empty strings and nil values.
            .enumerated()
            .map { index, instruction -> String in
                // Regular expression to match the pattern "number. "
                let pattern = "^[0-9]+\\.\\s*"
                if let regex = try? NSRegularExpression(pattern: pattern, options: []),
                   regex.firstMatch(in: instruction, options: [], range: NSRange(location: 0, length: instruction.utf16.count)) != nil {
                    // If instruction starts with a number, remove it
                    let newInstruction = instruction.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
                    return "\(index + 1). \(newInstruction)"
                } else {
                    // If instruction does not start with a number, add it
                    return "\(index + 1). \(instruction)"
                }
            } ?? []
    }
    
    /// Per MealDB documentation, adding the preview option to the path will produce a thumbnail image.
    private func constructThumbnailUrl(from imageUrl: URL?) -> URL? {
        guard let imagePath = imageUrl?.absoluteString else { return nil }
        return URL(string: "\(imagePath)/preview")
    }
}

// MARK: - ENCODING

extension Recipe {
    
    // Implement the custom encoder.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        // Encode all the straightforward properties
        try container.encode(String(id), forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(drinkAlternate, forKey: .drinkAlternate)
        try container.encode(category, forKey: .category)
        try container.encode(area, forKey: .area)
        try container.encode(instructionsString, forKey: .instructionsString)
        try container.encode(tags, forKey: .tags)
        try container.encode(imageUrl?.absoluteString, forKey: .imageURL)
        try container.encode(youtubeUrl?.absoluteString, forKey: .youtubeURL)
        try container.encode(sourceUrl?.absoluteString, forKey: .sourceURL)
        try container.encode(imageSourceUrl?.absoluteString, forKey: .imageSourceURL)

        // Encode ingredients
        for (index, ingredient) in ingredients.enumerated() {
            let ingredientIndex = index + 1
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(ingredientIndex)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(ingredientIndex)")!

            try container.encode(ingredient.name, forKey: ingredientKey)
            try container.encode(ingredient.measurement, forKey: measureKey)
        }

        // Encode empty strings for remaining ingredients and measurements
        for index in (ingredients.count + 1)...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(index)")!
            try container.encode("", forKey: ingredientKey)
            try container.encode("", forKey: measureKey)
        }
    }
}
