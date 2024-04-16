//
//  XCUIElementExtension.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 14/04/2024.
//

import Foundation
import XCTest

extension XCUIElement {
    
    func checkText(_ expectedText: String) {
        XCTAssertEqual(label, expectedText, "XCUIElement text: \(label). Expected text: \(expectedText)")
    }
    
    func checkHint(_ expectedHint: String) {
        XCTAssertEqual(placeholderValue!, expectedHint, "XCUIElement hint: \(placeholderValue!). Expected hint: \(expectedHint)")
    }
    
    func checkExists() {
        XCTAssert(exists)
    }
    
    func waitForElementToAppear(timeout: TimeInterval = 5) -> Bool {
        return waitForExistence(timeout: timeout)
    }
}
