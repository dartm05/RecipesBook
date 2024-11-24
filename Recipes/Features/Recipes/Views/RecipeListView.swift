//
//  RecipeListView.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//


import SwiftUI

struct IdentifiableUrl: Identifiable {
    let id = UUID()
    let url: URL
}

struct RecipeListView: View {
    @StateObject private var viewModel : RecipeListViewModel
    @State private var selectedVideoUrl: IdentifiableUrl? = nil
    @State private var searchText: String = ""
    
    
    init(viewModel:RecipeListViewModel){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.vertical)
                        .accessibilityIdentifier("ProgressView")
                } else if viewModel.recipes.isEmpty {
                    VStack{
                        Text("No recipes found")
                            .font(.title2)
                            .bold()
                            .padding(.vertical)
                           
                        Image("no_data")
                            .resizable()
                            .frame(maxWidth: 200, maxHeight: 200)
                            .padding(.horizontal)
                    }
                    
                }
                else {
                    ScrollView {
                        LazyVGrid( columns: [GridItem(.adaptive(minimum: 180))], spacing: 20){
                            ForEach(filteredRecipes) { recipe in
                                RecipeCellView(recipe: recipe, youtubeOnTap: {
                                    handleYouTubeTap(for: recipe)
                                })
                                .padding(.horizontal)
                                .onTapGesture {
                                    openWebsite(urlString: recipe.sourceUrl ?? "")
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .searchable(text : $searchText)
            .padding(.horizontal)
            .navigationTitle("Recipes")
            .navigationViewStyle(.stack)
            .onAppear {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
            .sheet(item: $selectedVideoUrl) { identifiableUrl in
                YouTubeWebView(url: identifiableUrl.url)
                    .accessibilityIdentifier("YouTubeWebView")
            }.onDisappear{
                selectedVideoUrl = nil
            }
        }
    }
    private func handleYouTubeTap(for recipe: Recipe) {
        if let urlString = recipe.youtubeUrl, let url = URL(string: urlString) {
            selectedVideoUrl = IdentifiableUrl(url: url)
        }
    }
    
    private var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return viewModel.recipes
        } else {
            return viewModel.recipes.filter { recipe in
                recipe.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}


