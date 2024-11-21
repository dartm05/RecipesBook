//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import Combine

@MainActor
final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    private let fetchRecipesUseCase: FetchRecipesUseCaseProtocol
    
    init(fetchRecipesUseCase: FetchRecipesUseCaseProtocol) {
        self.fetchRecipesUseCase = fetchRecipesUseCase
    }
    
    func fetchRecipes() async{
        isLoading = true
        error = nil
        
            do {
                let recipes = try await self.fetchRecipesUseCase.fetchRecipes()
                self.recipes = recipes ?? []
            } catch {
                self.error = error.localizedDescription
                self.isLoading = false
            }
            
            self.isLoading = false
     
    }
    
    
}
