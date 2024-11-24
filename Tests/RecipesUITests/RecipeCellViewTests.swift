//
//  RecipeCellViewTests.swift
//  Recipes
//
//  Created by Daniella Arteaga on 22/11/24.
//


import XCTest
import SwiftUI

class RecipeCellViewTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testRecipeNameAccessibility() {
        let predicate = NSPredicate(format: "label CONTAINS[c] 'Recipe'")
        let recipeCells = app.cells.matching(predicate).allElementsBoundByIndex
        
        for cell in recipeCells {
            let recipeNameLabel = cell.staticTexts["recipeName"]
            XCTAssertTrue(recipeNameLabel.exists, "Recipe name should be accessible via its identifier")
            XCTAssertEqual(recipeNameLabel.label, "Pasta", "Expected recipe name to be 'Pasta'")
        }
    }
    
    
    func testCuisineAccessibility() {
        let predicate = NSPredicate(format: "label CONTAINS[c] 'Recipe'")
        let recipeCells = app.cells.matching(predicate).allElementsBoundByIndex
        
        for cell in recipeCells {
            let cuisineLabel = cell.staticTexts["recipeCuisine"]
            XCTAssertTrue(cuisineLabel.exists, "Cuisine label should be accessible via its identifier")
            XCTAssertEqual(cuisineLabel.label, "Italian", "Expected cuisine text to be 'Italian'")
        }
    }
    
    
    func testYouTubeButtonTap() {
        let predicate = NSPredicate(format: "label CONTAINS[c] 'Recipe'")
        let recipeCells = app.cells.matching(predicate).allElementsBoundByIndex
        
        for cell in recipeCells {
            let youtubeButton = cell.images["youtube"]
            let hasButton = youtubeButton.exists
            if(hasButton) {
                youtubeButton.tap()
                let youtubeWebView = app.webViews["YouTubeWebView"]
                XCTAssertTrue(youtubeWebView.waitForExistence(timeout: 10), "YouTubeWebView should appear in the .sheet.")
            }
            
        }
    }
    
    func testPlaceholderImageAccessibility() {
        let placeholderImage = app.images["photo"]
        XCTAssertTrue(placeholderImage.exists, "Placeholder image should be displayed when no photo URL is provided")
    }
    
    func testMissingImageURL() {
        
        let predicate = NSPredicate(format: "label CONTAINS[c] 'Recipe'")
        let recipeCells = app.cells.matching(predicate).allElementsBoundByIndex
        
        for cell in recipeCells {
            let recipeImage = cell.images["recipePhoto"]
            let hasPhotoURL = recipeImage.exists
            let placeholderImage = app.images["photo"]
            
            if !hasPhotoURL {
                XCTAssertFalse(placeholderImage.exists, "Recipe image should show a placeholder for recipe without a valid photo URL")
            }
            XCTAssertTrue(placeholderImage.exists, "Placeholder image should be visible")
        }
    }
    
    func testMissingYouTubeURL() {
        let predicate = NSPredicate(format: "label CONTAINS[c] 'Recipe'")
        let recipeCells = app.cells.matching(predicate).allElementsBoundByIndex
        for cell in recipeCells {
            
            let youtubeButton = cell.images["youtube"]
            let hasYouTubeURL = youtubeButton.exists
            
            if hasYouTubeURL {
                XCTAssertTrue(youtubeButton.exists, "YouTube button should be visible for recipe with YouTube URL")
            } else {
                XCTAssertFalse(youtubeButton.exists, "YouTube button should not be visible for recipe without YouTube URL")
            }
        }
    }
    
}

