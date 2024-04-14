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
            .clickSignInButton()
            .enterCredentials(email: "test", password: "test")
    }
    
    func test_example2() {
        WelcomeScreen(app)
            .verifyScreenElements()
            .clickSignUpButton()
    }
}
