//
//  DIContainerKey.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import Swinject
import Foundation
import SwiftUI

@MainActor
private struct DIContainerKey: @preconcurrency EnvironmentKey {
    static let defaultValue: DIContainer = DIContainer.shared
}

extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}

@MainActor
final class DIContainer: ObservableObject {
    static let shared = DIContainer()
    let container: Container
    let recipesService: RecipesServiceProtocol
    var errorManager: ErrorManager
    var networkMonitor: NetworkMonitor
    
    
    private init() {
        container = Container()
        self.errorManager = ErrorManager()
        self.networkMonitor = NetworkMonitor(errorManager: self.errorManager)
        if CommandLine.arguments.contains("--uitesting") {
            self.errorManager = ErrorManager()
            self.networkMonitor = NetworkMonitor(errorManager: self.errorManager)
            self.recipesService = MockRecipesService(errorManager: self.errorManager)
        } else {
            self.recipesService = RecipesService(errorManager: self.errorManager)
        }
        setupDependencies()
    }
    
    
    private func setupDependencies() {
        container.register(ErrorManager.self) { _ in self.errorManager }.inObjectScope(.container)
        container.register(NetworkMonitor.self) { _ in self.networkMonitor }.inObjectScope(.container)
        container.register(RecipesServiceProtocol.self) { _ in self.recipesService }.inObjectScope(.container)
        
        
        container.register(RecipeRepositoryProtocol.self) { resolver in
            RecipeRepository(apiService: resolver.resolve(RecipesServiceProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(FetchRecipesUseCase.self) { resolver in
            FetchRecipesUseCase(recipeRepository: resolver.resolve(RecipeRepositoryProtocol.self)!)
        }
        container.register(RecipeListViewModel.self) { resolver in
            RecipeListViewModel(fetchRecipesUseCase: resolver.resolve(FetchRecipesUseCase.self)!)
        }
    }
    
    func resolveViewModel() -> RecipeListViewModel {
        return container.resolve(RecipeListViewModel.self)!
    }
}
