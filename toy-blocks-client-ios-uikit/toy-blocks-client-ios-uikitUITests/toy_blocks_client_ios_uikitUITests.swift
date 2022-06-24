//
//  toy_blocks_client_ios_uikitUITests.swift
//  toy-blocks-client-ios-uikitUITests
//
//  Created by Thiago Galvani on 22/06/22.
//

import XCTest

class toy_blocks_client_ios_uikitUITests: XCTestCase {

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
        
        let tableIdentifier = "NodesTableView"
        
        XCTAssertTrue(app.tables[tableIdentifier].exists)
        XCTAssertTrue(app.staticTexts["Node 4"].exists)
        XCTAssertFalse(app.staticTexts["Blocks go Here"].exists)
        app.tables[tableIdentifier].cells.element(boundBy: 3).tap()
        XCTAssertTrue(app.staticTexts["Blocks go Here"].exists)
        app.tables[tableIdentifier].cells.element(boundBy: 3).tap()
        XCTAssertFalse(app.staticTexts["Blocks go Here"].exists)
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
