//
//  RecipesUITests.swift
//  RecipesUITests
//
//  Created by Daniella Arteaga on 20/11/24.
//

import XCTest
@testable import Recipes

final class RecipesUITests: XCTestCase {
    
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLoadingState() throws {
        let progressView = app.activityIndicators["In progress"]
        XCTAssertTrue(progressView.exists, "Progress view should be visible while loading.")
    }
    
    func testNoRecipesFound() throws {
        let noRecipesText = app.staticTexts["No recipes found"]
        XCTAssertTrue(noRecipesText.exists, "Text 'No recipes found' should be shown when no recipes exist.")
    }
    
    func testRecipeListDisplay() throws {
        let recipeCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(recipeCell.exists, "The recipe cell should be displayed if recipes exist.")
    }
    
    func testYouTubeLinkTap() throws {
        let recipeCell = app.tables.cells.element(boundBy: 0)
        recipeCell.tap()
        
        let sheetView = app.otherElements["YouTubeWebView"]
        XCTAssertTrue(sheetView.exists, "Sheet view should be presented when tapping on a recipe with a YouTube URL.")
    }
    
    func testYouTubeSheetDisplayOnTap() throws {
        let recipeCell = app.tables.cells.element(boundBy: 0)
        recipeCell.tap()
        
        let sheetView = app.otherElements["YouTubeWebView"]
        XCTAssertTrue(sheetView.exists, "The YouTube web view should appear when tapping a recipe with a YouTube link.")
    }
    
    func testProgressViewDisappearsAfterLoading() throws {
        let progressView = app.activityIndicators["In progress"]
        
        let existsPredicate = NSPredicate(format: "exists == false")
        expectation(for: existsPredicate, evaluatedWith: progressView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(progressView.exists, "The progress view should disappear once data is loaded.")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
}

