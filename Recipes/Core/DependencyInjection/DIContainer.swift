//
//  DIContainerKey.swift
//  Recipes
//
//  Created by Daniella Arteaga on 21/11/24.
//
import SwiftUI

private struct DIContainerKey: EnvironmentKey {
    static let defaultValue: DIContainer = DIContainer()
}

extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
protocol DIContainerProtocol{
    func register<Service>(_ service: Service, for type: Service.Type)
    func resolve<Service>(_ type: Service.Type) -> Service?
}
final class DIContainer: DIContainerProtocol {
    
    static let shared = DIContainer()
    private var services: [String: Any] = [:]
    
    func register<Service>(_ service: Service, for type: Service.Type){
        let key = String(describing: type)
        services[key] = service
    }
    
    func resolve<Service>(_ type: Service.Type) -> Service?{
        let key = String(describing: type)
        guard let service = services[key] else { return nil }
        return service as? Service
    }
    
    static func testContainer(
        recipesService: RecipesServiceProtocol
    ) -> DIContainer{
        let container = DIContainer()
        let errorManager = ErrorManager()
        container.register(errorManager, for: ErrorManager.self)
        container.register(recipesService, for: RecipesServiceProtocol.self)
        let recipesRepository = RecipesRepository(apiService: recipesService)
        let recipesUseCase = RecipesUseCase(recipeRepository: recipesRepository)
        container.register(recipesUseCase, for: RecipesUseCaseProtocol.self)
        return container
    }
    
    static func configureProductionContainer() -> DIContainer {
        let container = DIContainer()
        let errorManager = ErrorManager()
        container.register(errorManager, for: ErrorManager.self)
        
        let networkManager = NetworkMonitor(errorManager: errorManager)
        container.register(networkManager, for: NetworkMonitor.self)
        
        let recipesService = RecipesService(errorManager: errorManager)
        container.register(recipesService, for: RecipesServiceProtocol.self)
        
        let recipeRepository = RecipesRepository(apiService: recipesService)
        let recipesUseCase = RecipesUseCase(recipeRepository: recipeRepository)
        container.register(recipesUseCase, for: RecipesUseCaseProtocol.self)
        
        return container
    }
}
