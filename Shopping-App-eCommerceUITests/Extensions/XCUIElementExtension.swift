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
    
    func checkExists() {
        XCTAssert(exists)
    }
}
