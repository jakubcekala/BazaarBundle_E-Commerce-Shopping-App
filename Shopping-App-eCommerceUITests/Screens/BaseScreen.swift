//
//  BaseScreen.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 14/04/2024.
//

import Foundation
import XCTest

class BaseScreen {
    
    var app: XCUIApplication
    
    init(_ app: XCUIApplication) {
        self.app = app
    }
    
    func dismissKeyboardIfPresent() {
        if app.keyboards.element(boundBy: 0).exists {
            app.keyboards.buttons["Return"].tap()
        }
    }
}
