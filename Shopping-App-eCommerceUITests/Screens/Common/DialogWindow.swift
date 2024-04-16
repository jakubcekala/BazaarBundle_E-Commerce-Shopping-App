//
//  DialogWindow.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 15/04/2024.
//

import Foundation

class DialogWindow: BaseScreen {
    
    func waitForDialog() {
        
    }
    
    func checkDialogContent(title: String, message: String) -> Self {
        app.alerts.staticTexts[title].waitForElementToAppear()
        app.alerts.staticTexts[title].checkExists()
        app.alerts.staticTexts[message].checkExists()
        return self
    }
    
    func dismissDialog() {
        app.alerts.buttons.firstMatch.tap()
    }
}
