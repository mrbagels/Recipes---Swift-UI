//
//  MockData.swift
//  RecipesTests
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

/// Provides basic JSON string values for testing. In a production environment, we would set up a run script that would check
/// time passed since last run and fetch a new copy of the JSON data after N time. This type of end to end testing would not only
/// provide errors when the model changes, but also alert us when the API response changes and the app fails as a result.
struct Mock {
    
    /// Mock invalid data object.
    static let invalidData = """
        Do you think this will work?,
        Nope: @truth -
        -
        
    """
    
    /// Mock filter response object.
    static let filterResponse = """
        {
            "meals": [
                {"strMeal":"Apam balik", "strMealThumb":"https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", "idMeal":"53049"},
                {"strMeal":"Apple & Blackberry Crumble", "strMealThumb":"https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", "idMeal":"52893"},
                {"strMeal":"Apple Frangipan Tart", "strMealThumb":"https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg", "idMeal":"52768"},
                {"strMeal":"Bakewell tart", "strMealThumb":"https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg", "idMeal":"52767"},
                {"strMeal":"Banana Pancakes", "strMealThumb":"https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg", "idMeal":"52855"},
                {"strMeal":"Battenberg Cake", "strMealThumb":"https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg", "idMeal":"52894"},
                {"strMeal":"BeaverTails", "strMealThumb":"https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg", "idMeal":"52928"},
                {"strMeal":"Blackberry Fool", "strMealThumb":"https://www.themealdb.com/images/media/meals/rpvptu1511641092.jpg", "idMeal":"52891"},
                {"strMeal":"Bread and Butter Pudding", "strMealThumb":"https://www.themealdb.com/images/media/meals/xqwwpy1483908697.jpg", "idMeal":"52792"},
                {"strMeal":"Budino Di Ricotta", "strMealThumb":"https://www.themealdb.com/images/media/meals/1549542877.jpg", "idMeal":"52961"}
            ]
        }
    """
    
    /// Mock detail response object.
    static let detailResponse = """
        {
          "meals": [
            {
              "idMeal": "53049",
              "strMeal": "Apam balik",
              "strDrinkAlternate": null,
              "strCategory": "Dessert",
              "strArea": "Malaysian",
              "strInstructions": "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\\r\\n\\r\\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\\r\\n\\r\\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\\r\\n\\r\\nCut into wedges and best eaten when it is warm.",
              "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
              "strTags": null,
              "strYoutube": "https://www.youtube.com/watch?v=6R8ffRRJcrg",
              "strIngredient1": "Milk",
              "strIngredient2": "Oil",
              "strIngredient3": "Eggs",
              "strIngredient4": "Flour",
              "strIngredient5": "Baking Powder",
              "strIngredient6": "Salt",
              "strIngredient7": "Unsalted Butter",
              "strIngredient8": "Sugar",
              "strIngredient9": "Peanut Butter",
              "strIngredient10": "",
              "strIngredient11": "",
              "strIngredient12": "",
              "strIngredient13": "",
              "strIngredient14": "",
              "strIngredient15": "",
              "strIngredient16": "",
              "strIngredient17": "",
              "strIngredient18": "",
              "strIngredient19": "",
              "strIngredient20": "",
              "strMeasure1": "200ml",
              "strMeasure2": "60ml",
              "strMeasure3": "2",
              "strMeasure4": "1600g",
              "strMeasure5": "3 tsp",
              "strMeasure6": "1/2 tsp",
              "strMeasure7": "25g",
              "strMeasure8": "45g",
              "strMeasure9": "3 tbs",
              "strMeasure10": " ",
              "strMeasure11": " ",
              "strMeasure12": " ",
              "strMeasure13": " ",
              "strMeasure14": " ",
              "strMeasure15": " ",
              "strMeasure16": " ",
              "strMeasure17": " ",
              "strMeasure18": " ",
              "strMeasure19": " ",
              "strMeasure20": " ",
              "strSource": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
              "strImageSource": null,
              "strCreativeCommonsConfirmed": null,
              "dateModified": null
            }
          ]
        }
    """
}
