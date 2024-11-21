//
//  RecipeServiceMock.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

// MockRecipesService.swift
import Foundation

class MockRecipesService : RecipesServiceProtocol {
    private let errorManager: ErrorManager
    
    init(errorManager: ErrorManager) {
        self.errorManager = errorManager
    }
    func fetchRecipes() async -> [Recipe]? {
        return MockData.recipes
    }
}
