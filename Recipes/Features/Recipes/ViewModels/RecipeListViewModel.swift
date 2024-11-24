//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import Combine
import Foundation
@MainActor
final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
 
    @Published var isLoading: Bool = false
    
    private let errorManager: ErrorManager
    private let recipesUseCase: RecipesUseCaseProtocol
    
    init(recipesUseCase: RecipesUseCaseProtocol, errorManager: ErrorManager) {
        self.recipesUseCase = recipesUseCase
        self.errorManager = errorManager
    }
    
    func fetchRecipes() async {
        isLoading = true
        do {
            let result = try await recipesUseCase.fetchRecipes()
            DispatchQueue.main.async {
                self.recipes = result ?? []
                self.isLoading = false
            }
        } catch let appError as AppError {
            self.errorManager.handleError(appError)
            DispatchQueue.main.async {
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorManager.handleError(.badResponse)
                self.isLoading = false
            }
        }
        
    }
}
