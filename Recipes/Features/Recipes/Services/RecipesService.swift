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
        do {
            guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
                let error = URLError(.badURL)
                errorManager.handleError(AppError(title: "Invalid URL", message: error.localizedDescription))
                throw error
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = URLError(.badServerResponse)
                errorManager.handleError(AppError(title: "Server Error", message: "Failed with status code: \(response as? HTTPURLResponse)?.statusCode ?? 0"))
                throw error
            }
            
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(Recipes.self, from: data)
            
            return recipeResponse.recipes.filter { $0.isValid }
            
        } catch {
            errorManager.handleError(AppError(title: "Network Error", message: error.localizedDescription))
            throw error
        }
    }
}



