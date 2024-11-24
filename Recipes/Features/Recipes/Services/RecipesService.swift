//
//  RecipesService.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//
import Foundation
import os

protocol RecipesServiceProtocol {
    func fetchRecipes() async throws-> [Recipe]?
}
final class RecipesService: RecipesServiceProtocol {
    private let errorManager: ErrorManager
    
    init(errorManager: ErrorManager) {
        self.errorManager = errorManager
    }
    
    func fetchRecipes() async throws -> [Recipe]? {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json") else {
            throw AppError.badResponse
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AppError.badResponse
        }
        
        let decoder = JSONDecoder()
        do {
            let recipeResponse = try decoder.decode(Recipes.self, from: data)
            return recipeResponse.recipes.filter { $0.isValid }
        } catch {
            throw AppError.decodingError
        }
    }
}



