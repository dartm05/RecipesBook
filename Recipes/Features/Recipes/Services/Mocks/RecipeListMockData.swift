//
//  RecipeListMockData.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

// MockData.swift
import Foundation

struct MockData {
    static let recipes: [Recipe] = [
        Recipe(id: "1", name: "Pasta", cuisine: "Italian", sourceUrl:"https://example.com" , youtubeUrl: "https://youtube.com" , photoUrlSmall: "https://example.com", photoUrlLarge: "https://example.com"),
        Recipe(id: "2", name: "Pasta", cuisine: "Italian", sourceUrl: nil, youtubeUrl: "https://youtube.com" , photoUrlSmall: "https://example.com", photoUrlLarge: "https://example.com"),
        Recipe(id: "3", name: "Pasta", cuisine: "Italian", sourceUrl: "https://example.com" , youtubeUrl: nil, photoUrlSmall: "https://example.com", photoUrlLarge: "https://example.com"),
        Recipe(id: "3", name: "Pasta", cuisine: "Italian", sourceUrl: "https://example.com" , youtubeUrl: nil, photoUrlSmall:  nil, photoUrlLarge: nil)
    ]
}
