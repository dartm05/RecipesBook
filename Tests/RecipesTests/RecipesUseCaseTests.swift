//
//  RecipesUseCaseTests.swift
//  Recipes
//
//  Created by Daniella Arteaga on 22/11/24.
//

import XCTest
@testable import Recipes

final class RecipesUseCaseTests: XCTestCase {
    
    func testFetchRecipesSuccess() async throws {
        let service = MockRecipesService(state: .success(MockData.recipes))
        let diContainer = DIContainer.testContainer(recipesService: service)
        let useCase = diContainer.resolve(RecipesUseCaseProtocol.self)
        
        let recipes = try await useCase!.fetchRecipes()
        
        XCTAssertNotNil(recipes, "Recipes should not be nil")
        XCTAssertEqual(recipes?.count, 4, "Should fetch 4 recipe")
    }
    
    func testFetchRecipesFailure() async throws {
        let service = MockRecipesService(state: .failure(AppError.badResponse))
        let diContainer = DIContainer.testContainer(recipesService: service)
        let useCase = diContainer.resolve(RecipesUseCaseProtocol.self)
        
        do {
            _ = try await useCase!.fetchRecipes()
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertEqual(error as? AppError, AppError.badResponse, "Expected bad response error")
        }
    }
}
