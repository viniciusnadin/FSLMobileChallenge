//
//  ToyBlocksUITests.swift
//  ToyBlocksUITests
//
//  Created by FullStack Labs on 01/09/21.
//

import XCTest

class ToyBlocksUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNodeToogle() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.scrollViews["NodesScrollView"].exists)
        XCTAssertTrue(app.scrollViews["NodesScrollView"].otherElements.staticTexts["Node 4"].waitForExistence(timeout: 2))
        app.scrollViews["NodesScrollView"].otherElements.staticTexts["Node 4"].firstMatch.tap()
        XCTAssertTrue(app.scrollViews["NodesScrollView"].otherElements.staticTexts["Blocks go here"].exists)
        app.scrollViews["NodesScrollView"].otherElements.staticTexts["Node 4"].firstMatch.tap()
        XCTAssertFalse(app.scrollViews["NodesScrollView"].otherElements.staticTexts["Blocks go here"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
