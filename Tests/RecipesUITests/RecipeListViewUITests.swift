//
//  RecipeListViewUITests.swift
//  Recipes
//
//  Created by Daniella Arteaga on 22/11/24.
//


import XCTest

class RecipeListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testRecipeListDisplaysRecipes() {
        let firstRecipeName = app.staticTexts["recipeName"]
        
        XCTAssertTrue(firstRecipeName.waitForExistence(timeout: 10),
                      "The first recipe name should be visible in the list")
    }
    
    func testSearchFunctionality() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "The search bar should exist")
        
        searchField.tap()
        searchField.typeText("Pasta")
        
        let filteredRecipe = app.staticTexts["Pasta"]
        XCTAssertTrue(filteredRecipe.waitForExistence(timeout: 5),
                      "Filtered recipe with name 'Pasta' should appear in the list")
    }
    
    func testEmptyStateDisplay() {
        app.launchArguments.append("--emptyList")
        app.launch()
        
        let noRecipesMessage = app.staticTexts["No recipes found"]
        XCTAssertTrue(noRecipesMessage.waitForExistence(timeout: 5),
                      "'No recipes found' message should appear when the list is empty")
    }
    
    func testLoadingState() {
        
        app.launchArguments.append("--uitesting")
        app.launchArguments.append("--loadingState")
        app.launch()
        
        
        let progressView = app.activityIndicators["ProgressView"]
        XCTAssertTrue(progressView.exists, "The ProgressView should be visible while loading")
        
        
        let firstRecipeName = app.staticTexts["No recipes found"]
        XCTAssertTrue(firstRecipeName.waitForExistence(timeout: 3),
                      "The recipes should be displayed after the loading is complete")
        
        XCTAssertFalse(progressView.exists, "The ProgressView should disappear after loading completes")
    }
    
    
    
    func testRecipeItemTapOpensSourceURL() {
        
        let firstRecipe = app.images["photo"].firstMatch
        XCTAssertTrue(firstRecipe.exists, "The first recipe cell should be present")
        firstRecipe.tap()
        sleep(2)
        XCTAssertFalse(app.otherElements["RecipesView"].exists, "The Recipes view should not be visible when Safari is open")
        
    }
    
    func testYouTubeButtonOpensYouTubeWebView() {
        let youtubeButton = app.images["youtube"].firstMatch
        XCTAssertTrue(youtubeButton.exists, "YouTube button should exist in the recipe cell")
        
        youtubeButton.tap()
        
        let youtubeWebView = app.webViews["YouTubeWebView"]
        XCTAssertTrue(youtubeWebView.waitForExistence(timeout: 10),
                      "YouTube web view should appear after tapping the YouTube button")
    }
}
