//
//  RecipesApp.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    var diContainer = DIContainer()
    
    init() {
        if(CommandLine.arguments.contains("--uitesting")){
            if(CommandLine.arguments.contains("--emptyList")){
                diContainer = DIContainer.testContainer(recipesService: MockRecipesService(state: .empty))
            }
            else if(CommandLine.arguments.contains("--loadingState")){
                diContainer = DIContainer.testContainer(recipesService: MockRecipesService(state: .loading))
            }
            else{
                diContainer = DIContainer.testContainer(recipesService: MockRecipesService(state: .success(MockData.recipes)))
            }
            
        }
        else{
            let container = DIContainer()
            let errorManager = ErrorManager()
            container.register(errorManager, for: ErrorManager.self)
            let networkManager = NetworkMonitor(errorManager: errorManager)
            container.register(networkManager, for: NetworkMonitor.self)
            let recipesService = RecipesService(errorManager: errorManager)
            container.register(recipesService, for: RecipesServiceProtocol.self)
            let recipeRepository = RecipesRepository(apiService: recipesService)
            let recipesUseCase = RecipesUseCase(recipeRepository: recipeRepository )
            container.register(recipesUseCase, for: RecipesUseCaseProtocol.self)
            
            diContainer = container
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView(errorManager: diContainer.resolve(ErrorManager.self)!)
                .environment(\.diContainer, diContainer)
            
        }
    }
}
