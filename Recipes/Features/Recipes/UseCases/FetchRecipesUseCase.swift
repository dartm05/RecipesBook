//
//  FetchRecipesUseCase.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import Foundation

protocol FetchRecipesUseCaseProtocol {
    func fetchRecipes() async throws -> [Recipe]?
}

final class FetchRecipesUseCase: FetchRecipesUseCaseProtocol {
    
    let recipeRepository: RecipeRepositoryProtocol
    
    init(recipeRepository: RecipeRepositoryProtocol) {
        self.recipeRepository = recipeRepository
    }
    
    func fetchRecipes() async throws -> [Recipe]? {
       return try await recipeRepository.fetchRecipes()
    }
    
}
