//
//  Recipe.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let cuisine: String
    let sourceUrl: String?
    let youtubeUrl: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
    }
}

