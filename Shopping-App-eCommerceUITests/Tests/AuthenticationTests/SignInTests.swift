//
//  AuthenticationTests.swift
//  Shopping-App-eCommerceUITests
//
//  Created by Jakub Cekała on 14/04/2024.
//

import Foundation

class AuthenticationTests: BaseTest {

    func test_example() {
        WelcomeScreen(app)
            .verifyScreenElements()
            .tapSignInButton()
            .enterCredentials(email: "test", password: "test")
            .tapSignInButton()
        DialogWindow(app)
            .checkDialogContent(title: "ERROR", message: "The email address is badly formatted.")
            .dismissDialog()
    }
    
    func test_example2() {
        WelcomeScreen(app)
            .verifyScreenElements()
            .tapSignUpButton()
    }
}
