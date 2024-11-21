//
//  RecipeRepository.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

protocol RecipeRepositoryProtocol {
    func fetchRecipes() async throws -> [Recipe]?
}

final class RecipeRepository: RecipeRepositoryProtocol {
    private let apiService: RecipesServiceProtocol
    
    init(apiService: RecipesServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchRecipes() async throws -> [Recipe]? {
        try await apiService.fetchRecipes()
    }
}
