//
//  ValidRecipeExtension.swift
//  Recipes
//
//  Created by Daniella Arteaga on 19/11/24.
//

extension Recipe {
    var isValid: Bool {
        return !id.isEmpty && !name.isEmpty
    }
}
