//
//  File.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 14/04/2024.
//

import Foundation
import XCTest

class WelcomeScreen: BaseScreen {
    
    private lazy var welcomeLogo = app.images.matching(identifier: "welcomeLogo7").element
    private lazy var signInButton = app.buttons.matching(identifier: "SignInButton").element
    private lazy var signUpButton = app.buttons.matching(identifier: "SignUpButton").element
    
    func tapSignInButton() -> SignInScreen {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Clicking (Sign in) Button")) { _ in
            signInButton.tap()
            return SignInScreen(app)
        }
    }
    
    func tapSignUpButton() -> SignUpScreen {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Clicking (Sign up) Button")) { _ in
            signUpButton.tap()
            return SignUpScreen(app)
        }
    }
    
    func verifyScreenElements() -> Self {
        XCTContext.runActivity(named: String(format: Constants.stepLog, "Checking Welcome Screen content")) { _ in
            welcomeLogo.checkExists()
            signInButton.checkExists()
            signUpButton.checkExists()
            signInButton.checkText("Sign in")
            signUpButton.checkText("Sign up")
            return self
        }
    }
}
