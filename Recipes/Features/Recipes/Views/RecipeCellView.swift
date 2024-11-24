//
//  RecipedCellView.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import SwiftUI

struct RecipeCellView: View {
    let recipe: Recipe
    let youtubeOnTap: () -> Void
    
    var body: some View {
        VStack{
            RecipeImageCell(recipe: recipe)
            RecipeDetailsView(recipe: recipe, youtubeOnTap: youtubeOnTap)
        }
        .scrollTransition{ content, phase in
            content
                .scaleEffect(phase.isIdentity ? 1 : 0.7)
                .opacity(phase.isIdentity ? 1 : 0.5)
        }
        
    }
}

struct RecipeDetailsView: View {
    let recipe: Recipe
    let youtubeOnTap: () -> Void
    
    var body: some View {
        HStack {
            if recipe.youtubeUrl != nil {
                Image("youtube")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        youtubeOnTap()
                    }
            }
            Text(recipe.cuisine)
                .font(.headline)
                .accessibilityIdentifier("recipeCuisine")
        }
    }
}

struct RecipeImageCell: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: recipe.photoUrlLarge ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom) {
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 130)
                            .padding()
                            .accessibilityIdentifier("recipeName")
                    }
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottom) {
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 130)
                            .padding()
                            .accessibilityIdentifier("recipeName")
                    }
            }
        }
        .frame(width: 180, height: 220, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
