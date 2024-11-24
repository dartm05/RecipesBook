//
//  RecipeServiceMock.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//
import Foundation

final class MockRecipesService: RecipesServiceProtocol {
    enum State {
        case loading
        case success([Recipe])
        case empty
        case failure(Error)
    }
    
    private let state: State?
    
    init(state: State?) {
        self.state = state ?? .loading
    }
    
    func fetchRecipes() async throws -> [Recipe]? {
        switch state {
        case .loading:
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            return []
        case .success(let recipes):
            return recipes
        case .empty:
            return []
        case .failure(let error):
            throw error
            
        default :
            return []
        }
        
    }
}
