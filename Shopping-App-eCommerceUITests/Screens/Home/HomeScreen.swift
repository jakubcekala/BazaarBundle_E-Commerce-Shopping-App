//
//  HomeScreen.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 16/04/2024.
//

import Foundation

class HomeScreen: BaseScreen {
    
    private lazy var categoriesText = app.staticTexts.matching(identifier: "Categories").element

    func verifyScreenElements() {
        categoriesText.waitForElementToAppear()
        categoriesText.checkExists()
    }
}
