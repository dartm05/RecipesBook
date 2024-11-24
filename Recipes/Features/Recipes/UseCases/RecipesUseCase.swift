//
//  FetchRecipesUseCase.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import Foundation

protocol RecipesUseCaseProtocol {
    func fetchRecipes() async throws -> [Recipe]?
}

final class RecipesUseCase: RecipesUseCaseProtocol {
    
    let recipeRepository: RecipesRepositoryProtocol
    
    init(recipeRepository: RecipesRepositoryProtocol) {
        self.recipeRepository = recipeRepository
    }
    
    func fetchRecipes() async throws -> [Recipe]? {
       return try await recipeRepository.fetchRecipes()
    }
    
}
