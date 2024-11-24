//
//  RecipesViewModelTests.swift
//  Recipes
//
//  Created by Daniella Arteaga on 22/11/24.
//

import XCTest
@testable import Recipes

final class RecipesViewModelTests: XCTestCase {
    
    func testFetchRecipesSuccess() async {
        
        let diContainer = DIContainer.testContainer(recipesService: MockRecipesService(state: .success(MockData.recipes)))
        let recipesUseCase = diContainer.resolve(RecipesUseCaseProtocol.self)!
        let errorManager = diContainer.resolve(ErrorManager.self)!
        let viewModel = await RecipeListViewModel(recipesUseCase: recipesUseCase , errorManager: errorManager)
        
        await viewModel.fetchRecipes()
        
        let fetchedRecipes = await viewModel.recipes
        XCTAssertEqual(fetchedRecipes.count, MockData.recipes.count, "The number of recipes should match the mock data.")
    }
    
    func testFetchRecipesFailure() async {
        let diContainer = DIContainer.testContainer(
            recipesService: MockRecipesService(state: .failure(AppError.networkError))
        )
        let recipesUseCase = diContainer.resolve(RecipesUseCaseProtocol.self)!
        let errorManager = diContainer.resolve(ErrorManager.self)!
        let viewModel = await RecipeListViewModel(recipesUseCase: recipesUseCase , errorManager: errorManager)

        await viewModel.fetchRecipes()
        
        await MainActor.run {
               let currentError = errorManager.currentError
               XCTAssertNotNil(currentError, "Expected an error to be set in the error manager")
               XCTAssertEqual(currentError?.title, "Network Error", "Expected a network error")
           }
    }
    
    
    func testFetchRecipesEmptyData() async {
        let diContainer = DIContainer.testContainer(
            recipesService: MockRecipesService(state: .success([]))
        )
        let recipesUseCase = diContainer.resolve(RecipesUseCaseProtocol.self)!
        let errorManager = diContainer.resolve(ErrorManager.self)!
        let viewModel = await RecipeListViewModel(recipesUseCase: recipesUseCase , errorManager: errorManager)
        
        await viewModel.fetchRecipes()
        
        let fetchedRecipes = await viewModel.recipes
        XCTAssertTrue(fetchedRecipes.isEmpty, "Expected empty recipe list but found \(fetchedRecipes.count) recipes")
    }

    
    
    
}

