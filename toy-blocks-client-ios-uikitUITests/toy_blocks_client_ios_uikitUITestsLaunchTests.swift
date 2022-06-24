//
//  toy_blocks_client_ios_uikitUITestsLaunchTests.swift
//  toy-blocks-client-ios-uikitUITests
//
//  Created by Thiago Galvani on 22/06/22.
//

import XCTest

class toy_blocks_client_ios_uikitUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
