//
//  ContentView.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.diContainer) private var diContainer
    @ObservedObject var errorManager: ErrorManager
    
    init( errorManager: ErrorManager) {
        self.errorManager = errorManager
    }
    var body: some View {
        let viewModel = diContainer.resolveViewModel()
        
        RecipeListView(viewModel: viewModel)
            .alert(item: $errorManager.currentError) { appError in
                Alert(
                    title: Text(appError.title),
                    message: Text(appError.message),
                    dismissButton: .default(Text("OK")) {
                        diContainer.errorManager.clearError()
                    }
                )
            }
    }
}

#Preview {
    ContentView( errorManager: .shared)
}
